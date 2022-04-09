import 'package:chat_app_basic/ui/pages/auth/create_user.dart';
import 'package:chat_app_basic/ui/pages/auth/login_page.dart';
import 'package:chat_app_basic/ui/pages/chat_solo_page.dart';
import 'package:chat_app_basic/ui/pages/friends_list_page.dart';
import 'package:chat_app_basic/ui/pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'レビューアプリ',
      );

  /// ルーティング設定
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/', // ベース：認証状態を識別してホーム画面orログインへ遷移させる
        builder: (BuildContext context, GoRouterState state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/login', // ログイン画面
        builder: (BuildContext context, GoRouterState state) => const MailLoginPage(),
      ),
      GoRoute(
        path: '/createUser', // 新規ユーザー登録画面
        builder: (BuildContext context, GoRouterState state) => const RegistUserWithMail(),
      ),
      GoRoute(
        path: '/setting', // ユーザープロフィール画面
        builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
      ),
      // GoRoute(
      //   path: '/reviewDetail/:id', // レビュー詳細ページ
      //   builder: (context, state) {
      //     // パスパラメータの値を取得するには state.params を使用
      //     final int id = int.parse(state.params['id']!);
      //     return ReviewDetail(id: id);
      //   },
      // ),
    ],
    initialLocation: '/',
  );
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
