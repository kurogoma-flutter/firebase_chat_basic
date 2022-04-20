import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'chat_items.dart';

/// TODO: ともだちとのチャットを表示（サブコレクション）

class ChatScreenFriends extends StatefulWidget {
  const ChatScreenFriends({Key? key, required this.myUid, required this.friendsUid}) : super(key: key);
  final String myUid;
  final String friendsUid;

  @override
  State<ChatScreenFriends> createState() => _ChatScreenFriendsState();
}

class _ChatScreenFriendsState extends State<ChatScreenFriends> {
  // 相手ユーザーデータを取得
  List<DocumentSnapshot> friendData = [];
  _getFriendData() async {
    var document = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: widget.friendsUid).limit(1).get();
    setState(() {
      friendData = document.docs;
    });
  }

  // チャットデータ取得
  List<DocumentSnapshot> _chatData = [];
  _getChatData() async {
    var document = await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc('iDUQweyzoVQJt8IloDMb')
        .collection('chatContents')
        .orderBy('timestamp', descending: false)
        .get();
    setState(() {
      _chatData = document.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      await _getFriendData();
      await _getChatData();
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
          friendData[0]['userName'],
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  children: _chatData.map((document) {
                    return _chatItem(document, friendData[0]['iconPath']);
                  }).toList(),
                ),
              ),
            ),
            TextInputWidget(),
          ],
        ),
      ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/ufo2.png',
                scale: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// テキストか画像を識別して返す
Widget _chatItem(DocumentSnapshot chatContent, String friendsIconPath) {
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
