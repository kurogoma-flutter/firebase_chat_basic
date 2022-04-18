import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  // ログインユーザー取得
  final user = FirebaseAuth.instance.currentUser;
  // クエリ処理で用いるリスト
  List<DocumentSnapshot> friendList = [];
  List<DocumentSnapshot> userList = [];
  List<dynamic> uidList = [];

  @override
  void initState() {
    super.initState();
    Future(() async {
      // friendsコレクションから、友達のUID一覧を取得
      var snapshot = await FirebaseFirestore.instance.collection('friends').where('hostUid', isEqualTo: user!.uid).get();
      setState(() {
        friendList = snapshot.docs;
      });
      // 検索用配列作成
      for (var element in friendList) {
        uidList.add(element['friendsUid']);
      }
      // 配列に合致するデータ一覧を取得
      var userSnapshot = await FirebaseFirestore.instance.collection('users').where('uid', whereIn: uidList[0]).get();
      setState(() {
        userList = userSnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        title: const Text(
          'ともだち一覧',
          style: TextStyle(color: Colors.black87),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black87,
            onPressed: () {},
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Mapにしてリスト表示をする
          children: userList.map((document) {
            return GestureDetector(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipOval(
                    child: Image.network(document['iconPath']),
                  ),
                ),
                trailing: const Text('3分前'),
                title: Text(document['userName']),
                subtitle: Text(document['comment'].toString()),
              ),
              onTap: () {
                // チャットページへ遷移 /chat/ログインユーザーのUID/選択した友達のUID
                context.go('/chat/${user!.uid.toString()}/${document['uid'].toString()}');
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
