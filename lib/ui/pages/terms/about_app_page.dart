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
              context.go('/setting');
            },
          ),
          title: const Text(
            'このアプリについて',
            style: TextStyle(color: Colors.black87),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black87,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                'アプリタイトル',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ver 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
