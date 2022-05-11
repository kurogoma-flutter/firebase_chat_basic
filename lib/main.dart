import 'package:chat_app_basic/providers/auth_provider.dart';
import 'package:chat_app_basic/providers/inquiry_provider.dart';
import 'package:chat_app_basic/services/logger.dart';
import 'package:chat_app_basic/services/routes.dart';
import 'package:chat_app_basic/ui/pages/auth/login_page.dart';
import 'package:chat_app_basic/ui/pages/chat/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  await Firebase.initializeApp();
  LineSDK.instance.setup("1657081646").then((_) {
    logger.i('LineSDK Prepared');
  });
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Inquiry>(
          create: (context) => Inquiry(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'レビューアプリ',
      ),
    );
  }
}

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ローディング画面などに書き換えても良い
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            // User が null でなない、つまりサインイン済みのホーム画面へ
            return const ChatScreen();
          } else {
            // User が null である、つまり未サインインのサインイン画面へ
            return const MailLoginPage();
          }
        });
  }
}
