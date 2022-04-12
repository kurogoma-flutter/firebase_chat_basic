import 'package:flutter/material.dart';

/// TODO: ともだちとのチャットを表示（サブコレクション）

class ChatScreenFriends extends StatefulWidget {
  const ChatScreenFriends({Key? key, required String myUid, required String friendsUid}) : super(key: key);

  @override
  State<ChatScreenFriends> createState() => _ChatScreenFriendsState();
}

class _ChatScreenFriendsState extends State<ChatScreenFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        title: const Text(
          'くろごま',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))],
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: ClipOval(
                              child: Image.asset('assets/images/github.png'),
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
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                '楽しいですね！！',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
      padding: EdgeInsets.symmetric(horizontal: 10),
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
