import 'package:chat_app_basic/ui/pages/settings/settings_page.dart';
import 'package:chat_app_basic/ui/pages/settings/user_profile.dart';
import 'package:chat_app_basic/ui/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/auth/create_user.dart';
import '../ui/pages/auth/login_page.dart';
import '../ui/pages/chat/chat_friends_page.dart';
import '../ui/pages/chat/chat_page.dart';
import '../ui/pages/error_page.dart';

/// ルーティング設定
final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
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
      path: '/setting', // 設定画面
      builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/test', // テストページ
      builder: (BuildContext context, GoRouterState state) => const TestPage(),
    ),
    GoRoute(
      path: '/userPage', // ユーザープロフィール画面
      builder: (BuildContext context, GoRouterState state) => const UserProfilePage(),
    ),
    GoRoute(
      path: '/chat/:myUid/:friendsUid', // レビュー詳細ページ
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
