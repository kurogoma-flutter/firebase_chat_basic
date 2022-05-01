import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              context.go('/');
            },
          ),
          title: const Text('このアプリについて'),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2,
        ),
      ),
    );
  }
}
