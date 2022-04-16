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
  // サブコレクションを取得(snapshot)

  // 相手ユーザーデータを取得
  List<DocumentSnapshot> _friendData = [];
  _getFriendData(friendsUid) async {
    var snapshotId = await FirebaseFirestore.instance.collection('user').where('uid', isEqualTo: friendsUid).limit(1).get();
    setState(() {
      _friendData = snapshotId.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFriendData('sss');
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
        title: const Text(
          'くろごま',
          style: TextStyle(
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
                ),
                child: ListView(
                  children: const [
                    RightBalloon(content: 'ほぉほぉ'),
                    LeftBalloon(content: 'ふぅん'),
                    RightBalloon(content: 'サンプル'),
                    RightBalloon(content: 'わーい'),
                    RightBalloon(content: 'わーい'),
                    RightImage(
                        imagePath:
                            'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/test%2F20210201_c1a.jpeg?alt=media&token=eef5bbec-9f67-4012-b480-3179b7ef5a44'),
                    LeftImage(
                        imagePath:
                            'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/test%2F2020109162212.png?alt=media&token=618bc073-7822-46f6-bd84-a9e98d68a92c'),
                    LeftBalloon(content: 'そうだよね'),
                  ],
                ),
              ),
            ),
            const TextInputWidget(),
          ],
        ),
      ),
    );
  }
}

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
              scale: 11,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/file.png',
              scale: 11,
            ),
          ),
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
                scale: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// チャットの要素を決定する
// chatItem => Firestoreで取得したドキュメント
_chatItem(chatContent) {
  // 画像か判別する
  if (chatContent['imagePath'] == '') {
    if (chatContent['uid'] == FirebaseAuth.instance.currentUser!.uid) {
      return RightBalloon(content: chatContent['text']);
    } else {
      return LeftBalloon(content: chatContent['text']);
    }
  } else {
    if (chatContent['uid'] == FirebaseAuth.instance.currentUser!.uid) {
      return RightImage(imagePath: chatContent['imagePath']);
    } else {
      return LeftImage(imagePath: chatContent['imagePath']);
    }
  }
}
