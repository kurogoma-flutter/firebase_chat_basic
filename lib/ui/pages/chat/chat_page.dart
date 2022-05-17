import 'package:chat_app_basic/ui/components/constants.dart';
import 'package:chat_app_basic/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

import 'chat_solo_page.dart';
import 'friends_list_page.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.tab}) : super(key: key);
  // パス設定
  int? tab;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // デフォルトは自分のチャットページから
  int pageIndex = defaultPageIndex;
  // BottomNavigationPage一覧
  List<Widget> bottomNavigationPages = [
    const FriendListPage(),
    const ChatScreenOnly(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.tab != null) {
        pageIndex = widget.tab!;
      }
      print(pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: bottomNavigationPages[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/friends.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            label: 'ともだち',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/solo_man.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            label: 'あなた',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/setting_image.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            label: 'せってい',
          ),
        ],
      ),
    );
  }
}
