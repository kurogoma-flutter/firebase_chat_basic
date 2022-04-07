import 'package:flutter/material.dart';

class ChatScreenOnly extends StatelessWidget {
  const ChatScreenOnly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        title: const Text(
          'チャット画面',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    RightBaloon(),
                    RightBaloon(),
                    RightBaloon(),
                  ],
                ),
              ),
            ),
            textInputWidget(),
          ],
        ),
      ),
    );
  }
}

class RightBaloon extends StatelessWidget {
  const RightBaloon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
            gradient: LinearGradient(begin: FractionalOffset.topLeft, end: FractionalOffset.bottomRight, colors: [
              Color(0xFFFF570D),
              Color(0xFFFF367F),
            ], stops: [
              0.0,
              1.0
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Flutter学習中！',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class textInputWidget extends StatelessWidget {
  const textInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.photo_outlined)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const TextField(
                autofocus: true,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const RotationTransition(
              turns: AlwaysStoppedAnimation(-45 / 360),
              child: Icon(Icons.send_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
