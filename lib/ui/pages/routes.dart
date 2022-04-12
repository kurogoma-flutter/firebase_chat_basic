import 'package:chat_app_basic/ui/pages/chat/settings_page.dart';
import 'package:chat_app_basic/ui/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth/create_user.dart';
import 'auth/login_page.dart';
import 'chat/chat_friends_page.dart';
import 'chat/chat_page.dart';

/// ルーティング設定
final GoRouter router = GoRouter(
  // errorBuilder: (context, state) => ErrorPage(),
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
    GoRoute(
      path: '/test', // ユーザープロフィール画面
      builder: (BuildContext context, GoRouterState state) => const TestPage(),
    ),
    GoRoute(
      path: '/chat/:myYid/:friendsUid', // レビュー詳細ページ
      builder: (context, state) {
        // パスパラメータの値を取得するには state.params を使用
        final String myUid = state.params['myUid']!;
        final String friendsUid = state.params['friendsUid']!;
        return ChatScreenFriends(myUid: myUid, friendsUid: friendsUid);
      },
    ),
  ],
  initialLocation: '/',
);
