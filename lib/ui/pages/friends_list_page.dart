import 'package:flutter/material.dart';

import 'chat_friends_page.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return const ChatScreenFriends();
              }));
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 8,
            ),
            leading: ClipOval(child: Image.asset('assets/images/kurogoma.png')),
            trailing: const Text('3分前'),
            title: const Text('USERくん'),
            subtitle: const Text('Flutter Chat App'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 8,
            ),
            leading: ClipOval(child: Image.asset('assets/images/github.png')),
            trailing: const Text('3分前'),
            title: const Text('GITくん'),
            subtitle: const Text('Flutter Chat App'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 8,
            ),
            leading: ClipOval(child: Image.asset('assets/images/kurogoma.png')),
            trailing: const Text('3分前'),
            title: const Text('USERくん'),
            subtitle: const Text('Flutter Chat App'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 8,
            ),
            leading: ClipOval(child: Image.asset('assets/images/github.png')),
            trailing: const Text('3分前'),
            title: const Text('GITくん'),
            subtitle: const Text('Flutter Chat App'),
          ),
        ],
      ),
    );
  }
}
