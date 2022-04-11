import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/date_methods.dart';
import 'authentication.dart';

class FirestoreMethods {
  DateMethods date = DateMethods();
  // 「あなた」ページのデータ一覧
  getYourChatData() {
    return FirebaseFirestore.instance.collection("yourRoom").orderBy("createdAt", descending: false).snapshots();
  }

  // 「あなた」ページのデータ保存
  Future<void> storeYourChat(String text) async {
    final user = await getLoggedInUser();
    await FirebaseFirestore.instance.collection('reviewList').add({
      'uid': user.uid,
      'text': text,
      'createAt': date.now,
    });
  }

  // ともだち一覧用ユーザーデータ取得
  Future getUserList() async {
    // yourRoomからログインユーザーのUIDが含まれるデータを取得
    final user = await getLoggedInUser();
    final Stream<QuerySnapshot> reviewStream =
        FirebaseFirestore.instance.collection('friends').where('myUid', isEqualTo: user.uid).where('pairUid', isEqualTo: user.uid).snapshots();
    return reviewStream;
  }

  // ユーザー個人データを取得
  Future getPersonalData() async {
    final user = await getLoggedInUser();
    return await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: user.uid).get();
  }
}
