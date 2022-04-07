import 'package:flutter/material.dart';

class ChatScreenOnly extends StatelessWidget {
  const ChatScreenOnly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            TextInputWidget(),
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

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 68,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/camera.png',
              scale: 11,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/file.png',
              scale: 11,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const TextField(
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
                maxLines: 1,
                maxLength: 400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/ufo2.png',
                scale: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
