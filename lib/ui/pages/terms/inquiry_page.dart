import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
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
          title: const Text('お問合せ'),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 2,
        ),
      ),
    );
  }
}
