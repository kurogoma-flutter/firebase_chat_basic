import 'package:chat_app_basic/ui/pages/chat_solo_page.dart';
import 'package:chat_app_basic/ui/pages/friends_list_page.dart';
import 'package:chat_app_basic/ui/pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int pageIndex = 0;

  List<Widget> bottomNavigationPages = [
    const MessageWidget(),
    const ChatScreenOnly(),
    const SettingsPage(),
  ];

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
