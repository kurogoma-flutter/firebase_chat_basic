import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            context.go('/');
          },
        ),
        title: const Text('プロフィール画面'),
      ),
      body: Center(
        child: Text('プロフィール'),
      ),
    );
  }
}
