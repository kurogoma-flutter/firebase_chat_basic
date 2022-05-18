import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/logger.dart';
import 'chat_items.dart';

class ChatScreenFriends extends StatefulWidget {
  const ChatScreenFriends({Key? key, required this.myUid, required this.friendsUid}) : super(key: key);
  final String myUid;
  final String friendsUid;

  @override
  State<ChatScreenFriends> createState() => _ChatScreenFriendsState();
}

class _ChatScreenFriendsState extends State<ChatScreenFriends> {
  // アイコンパス
  String userIconPath = '';
  // 相手のuid
  String friendsUid = '';
  // 相手のユーザー名
  String userName = '';
  // スクロール操作
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 1000 * 100);

  // 相手ユーザーデータを取得
  List<DocumentSnapshot> friendData = [];
  _getFriendData() async {
    logger.i('相手データ取得開始');
    try {
      var document = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: widget.friendsUid).limit(1).get();
      setState(() {
        friendData = document.docs;
        userIconPath = friendData[0]['iconPath'];
        friendsUid = friendData[0]['uid'];
        userName = friendData[0]['userName'];
      });
    } on FirebaseAuthException catch (e) {
      logger.e('ユーザーデータの取得に失敗しました。');
    }
  }

  // ユーザーデータ取得
  final Stream<QuerySnapshot> _chatItemStream = FirebaseFirestore.instance
      .collection('chatRoom')
      .doc('KWhVFN8xH6b1m57tUZIE')
      .collection('contents')
      .where('roomId', isEqualTo: 'KWhVFN8xH6b1m57tUZIE')
      .snapshots();

  @override
  void initState() {
    super.initState();
    Future(() async {
      await _getFriendData();
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
            context.go('/');
          },
        ),
        title: Text(
          userName,
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _chatItemStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                          return _chatItem(data, userIconPath);
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
class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 68,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/camera.png',
              scale: 1.6,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {},
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
              child: const TextField(
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                maxLines: 1,
                maxLength: 400,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
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
      return LeftBalloon(content: chatContent['text'], iconPath: friendsIconPath);
    }
  } else {
    if (chatContent['uid'] == FirebaseAuth.instance.currentUser!.uid) {
      return RightImage(imagePath: chatContent['imagePath']);
    } else {
      return LeftImage(imagePath: chatContent['imagePath'], iconPath: friendsIconPath);
    }
  }
}
