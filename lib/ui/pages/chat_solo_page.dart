import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// TODO: 登録処理・ImagePicker追加（カメラは最後）

class ChatScreenOnly extends StatefulWidget {
  const ChatScreenOnly({Key? key}) : super(key: key);

  @override
  State<ChatScreenOnly> createState() => _ChatScreenOnlyState();
}

class _ChatScreenOnlyState extends State<ChatScreenOnly> {
  final TextEditingController _textController = TextEditingController();
  late String _text;

  @override
  void initState() {
    super.initState();
  }

  final Stream<QuerySnapshot> _chatStream = FirebaseFirestore.instance.collection('yourRoom').orderBy('createdAt', descending: true).snapshots();

  _createAtText(data) {
    var timestamp = data['create_at'];
    DateTime createdAt;
    DateFormat format = DateFormat('yyyy-MM-dd-H:m');
    if (timestamp is Timestamp) {
      // toDate()でDateTimeに変換
      createdAt = timestamp.toDate();
    } else {
      createdAt = DateTime.now();
    }

    return format.format(createdAt).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              'ERROR!! Something went wrong',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: Colors.cyan,
              ),
            );
          }

          return SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return RightBaloon(text: data['text'] ?? '...');
                      }).toList(),
                    ),
                  ),
                ),
                TextInputWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RightBaloon extends StatelessWidget {
  const RightBaloon({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

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
              text,
              style: const TextStyle(color: Colors.white),
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
