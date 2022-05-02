import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermPage extends StatelessWidget {
  const TermPage({Key? key}) : super(key: key);

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
          title: const Text(
            '利用規約',
            style: TextStyle(color: Colors.black87),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2,
        ),
      ),
    );
  }
}
