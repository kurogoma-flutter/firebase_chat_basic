import 'package:flutter/material.dart';

/// チャット吹き出し（相手側）
class LeftBalloon extends StatelessWidget {
  const LeftBalloon({Key? key, required this.content, required this.iconPath}) : super(key: key);

  final String content;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            child: ClipOval(
              child: Image.network(iconPath),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  Color(0xFF7B3CFF),
                  Color(0xFF136FFF),
                ],
                stops: [0.0, 1.0],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                content,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// チャット吹き出し（自分側）
class RightBalloon extends StatelessWidget {
  const RightBalloon({
    Key? key,
    required this.content,
  }) : super(key: key);
  final String content;
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

/// 相手側画像
class LeftImage extends StatelessWidget {
  const LeftImage({Key? key, required this.imagePath, required this.iconPath}) : super(key: key);

  final String imagePath;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            CircleAvatar(
              child: ClipOval(
                child: Image.network(iconPath),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: size.width * 0.4,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 自分側画像
class RightImage extends StatelessWidget {
  const RightImage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: size.width * 0.4,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
