import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Error !!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text('ホームへ戻る'),
          ),
        ],
      ),
    );
  }
}
