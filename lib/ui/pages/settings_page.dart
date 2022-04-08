import 'package:flutter/material.dart';

/// TODO :
/// ログイン・アウト
/// 退会処理
/// ポリシーページ

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '設定をする',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Setting'),
        ),
      ),
    );
  }
}
