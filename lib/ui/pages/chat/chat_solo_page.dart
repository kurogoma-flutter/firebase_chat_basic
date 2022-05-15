import 'package:chat_app_basic/providers/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/firestore.dart';
import '../../../services/logger.dart';
import 'chat_items.dart';

class ChatScreenOnly extends StatefulWidget {
  const ChatScreenOnly({Key? key}) : super(key: key);

  @override
  State<ChatScreenOnly> createState() => _ChatScreenOnlyState();
}

class _ChatScreenOnlyState extends State<ChatScreenOnly> {
  FirestoreMethods methods = FirestoreMethods();

  late final Stream<QuerySnapshot> _chatStream;

  @override
  void initState() {
    super.initState();
    setState(() {
      _chatStream = methods.getYourChatData();
    });
  }

  _createAtText(data) {
    logger.i('日付処理開始');
    try {
      var timestamp = data['create_at'];
      DateTime createdAt;
      DateFormat format = DateFormat('yyyy-MM-dd-H:m');
      if (timestamp is Timestamp) {
        // toDate()でDateTimeに変換
        createdAt = timestamp.toDate();
      } else {
        createdAt = DateTime.now();
      }
      return format.format(createdAt).toString();
    } on Exception catch (e) {
      logger.w('日付データの処理に失敗しました。');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              'ERROR!! Something went wrong',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.cyan,
              ),
            );
          }

          return SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        if (data['imagePath'] == "") {
                          return RightBalloon(content: data['text']);
                        } else {
                          return RightImage(imagePath: data['imagePath']);
                        }
                      }).toList(),
                    ),
                  ),
                ),
                const TextInputWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// テキスト入力フォーム
class TextInputWidget extends StatefulWidget {
  const TextInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  // firestoreメソッド
  FirestoreMethods methods = FirestoreMethods();
  // テキスト文字列の操作
  final TextEditingController textController = TextEditingController();
  // 入力テキスト
  String _text = '';

  // 文字入力処理
  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  // フォームリセット
  void clearInput() {
    textController.clear();
    setState(() {
      _text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 68,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await context.read<ChatProvider>().getImageFromCamera();

              FirebaseStorage storage = FirebaseStorage.instance;
              try {
                String imageUrl = '';
                String imageName = context.read<ChatProvider>().imageName;
                final task = await storage.ref('images/$imageName').putFile(context.read<ChatProvider>().file!);
                imageUrl = await task.ref.getDownloadURL();

                await context.read<ChatProvider>().storeYourChatImage(imageUrl);
              } catch (e) {
                print(e);
              }
            },
            child: Image.asset(
              'assets/images/camera.png',
              scale: 1.6,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () async {
              await context.read<ChatProvider>().getImageFromGallery();
              FirebaseStorage storage = FirebaseStorage.instance;
              try {
                String imageUrl = '';
                String imageName = context.read<ChatProvider>().imageName;
                final task = await storage.ref('images/$imageName').putFile(context.read<ChatProvider>().file!);
                imageUrl = await task.ref.getDownloadURL();

                await context.read<ChatProvider>().storeYourChatImage(imageUrl);
              } catch (e) {
                logger.w(e);
              }
            },
            child: Image.asset(
              'assets/images/file.png',
              scale: 2,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: textController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                maxLines: 1,
                maxLength: 400,
                onChanged: _handleText,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              methods.storeYourChatMessage(_text);
              clearInput();
            },
            child: Image.asset(
              'assets/images/send.png',
              scale: 2.4,
            ),
          ),
        ],
      ),
    );
  }
}
