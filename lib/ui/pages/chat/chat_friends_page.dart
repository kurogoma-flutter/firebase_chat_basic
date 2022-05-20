import 'package:chat_app_basic/providers/chat_provider.dart';
import 'package:chat_app_basic/providers/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../services/logger.dart';
import 'chat_items.dart';

class ChatScreenFriends extends StatefulWidget {
  const ChatScreenFriends(
      {Key? key, required this.myUid, required this.friendsUid})
      : super(key: key);
  final String myUid;
  final String friendsUid;

  @override
  State<ChatScreenFriends> createState() => _ChatScreenFriendsState();
}

class _ChatScreenFriendsState extends State<ChatScreenFriends> {
  // ローディング管理
  bool isLoading = true;
  late final Stream<QuerySnapshot> chatItemStream;
  // スクロール操作
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 1000 * 100);

  @override
  void initState() {
    super.initState();
    Future(() async {
      await context.read<ChatProvider>().getFriendData(widget.friendsUid);
      await context.read<ChatProvider>().getChatRoomInfo();
      setState(() {
        chatItemStream = FirebaseFirestore.instance
            .collection('chatRoom')
            .doc(context.read<ChatProvider>().roomId)
            .collection('contents')
            .where('roomId', isEqualTo: context.read<ChatProvider>().roomId)
            .snapshots();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            context.go('/home/0');
          },
        ),
        title: Text(
          context.read<ChatProvider>().userName,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: chatItemStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    'ERROR!! Something went wrong',
                    style: TextStyle(fontSize: 30),
                  ));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(fontSize: 30),
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
                            controller: _scrollController,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return _chatItem(data,
                                  context.read<ChatProvider>().userIconPath);
                            }).toList(),
                          ),
                        ),
                      ),
                      const TextInputWidget(),
                    ],
                  ),
                );
              }),
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
                final task = await storage
                    .ref('images/$imageName')
                    .putFile(context.read<ChatProvider>().file!);
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
                final task = await storage
                    .ref('images/$imageName')
                    .putFile(context.read<ChatProvider>().file!);
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

// テキストか画像を識別して返す
Widget _chatItem(chatContent, String friendsIconPath) {
  // 画像か判別する
  if (chatContent['imagePath'] == '') {
    if (chatContent['uid'] == FirebaseAuth.instance.currentUser!.uid) {
      return RightBalloon(content: chatContent['text']);
    } else {
      return LeftBalloon(
          content: chatContent['text'], iconPath: friendsIconPath);
    }
  } else {
    if (chatContent['uid'] == FirebaseAuth.instance.currentUser!.uid) {
      return RightImage(imagePath: chatContent['imagePath']);
    } else {
      return LeftImage(
          imagePath: chatContent['imagePath'], iconPath: friendsIconPath);
    }
  }
}
