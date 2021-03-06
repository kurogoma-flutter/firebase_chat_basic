import 'package:chat_app_basic/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.5))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/userIcons%2Fa4vETEuh50Jfvkk1630203562_1630203566.png?alt=media&token=866dbc15-9d43-4a50-86de-bed6b9a910bd'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'プロフィール編集',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              onTap: () => context.go('/userPage'),
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.5))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/appImage%2Fimages.jpeg?alt=media&token=91254fd0-a2b6-4f81-b3ee-5c9cc886b281'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'お問い合わせ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              onTap: () {
                context.go('/inquiry');
              },
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.5))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/appImage%2Fimages.jpeg?alt=media&token=91254fd0-a2b6-4f81-b3ee-5c9cc886b281'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'このアプリについて',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              onTap: () {
                context.go('/aboutApp');
              },
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.5))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/appImage%2Fimages.jpeg?alt=media&token=91254fd0-a2b6-4f81-b3ee-5c9cc886b281'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          '利用規約',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              onTap: () {
                context.go('/term');
              },
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.5))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/chat-14a44-kurooon.appspot.com/o/appImage%2Fimages.jpeg?alt=media&token=91254fd0-a2b6-4f81-b3ee-5c9cc886b281'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'プライバシーポリシー',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              onTap: () {
                context.go('/policy');
              },
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () async {
                await context.read<AuthProvider>().signOut(context);
              },
              child: const Text(
                'サインアウト',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await context.read<AuthProvider>().deleteUser(context);
              },
              child: const Text(
                '退会する',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/test');
              },
              child: const Text('テスト'),
            ),
          ],
        ),
      ),
    );
  }
}
