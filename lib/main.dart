import 'package:chat_app_basic/chat_screen_only.dart';
import 'package:chat_app_basic/message_widget.dart';
import 'package:chat_app_basic/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int pageIndex = 0;

  List<Widget> bottomNavigationPages = [
    MessageWidget(),
    ChatScreenOnly(),
    Settings(),
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
            icon: IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: const Icon(Icons.chat),
            ),
            label: 'ともだち',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: const Icon(Icons.person_pin_outlined),
            ),
            label: 'あなた',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: const Icon(Icons.settings),
            ),
            label: 'せってい',
          ),
        ],
      ),
    );
  }
}
