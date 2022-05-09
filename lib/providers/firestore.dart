import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/date_methods.dart';
import 'authentication.dart';
import 'logger.dart';

class FirestoreMethods {
  DateMethods date = DateMethods();
  // 「あなた」ページのデータ一覧
  getYourChatData() {
    logger.i('「あなた」のチャットデータを取得開始');
    try {
      return FirebaseFirestore.instance.collection("yourRoom").orderBy("createdAt", descending: false).snapshots();
    } on Exception catch (e) {
      logger.e('「あなた」のチャットデータ取得でエラーが発生しました。');
    }
  }

  // 「あなた」ページのデータ保存
  storeYourChatMessage(String text) async {
    logger.i('あなたのチャットテキスト登録');
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (text != "") {
        await FirebaseFirestore.instance.collection('yourRoom').add({
          "uid": uid,
          "text": text,
          "imagePath": "",
          "createdAt": date.fireStoreFormat.format(DateTime.now()),
        });
      }
    } on Exception catch (e) {
      logger.e('テキスト登録中にエラーが発生しました');
    }
  }

  // ともだち一覧用ユーザーデータ取得
  Future getUserList() async {
    logger.i('ともだち一覧を取得するための配列作成');
    try {
      List<DocumentSnapshot> friendList = [];
      // yourRoomからログインユーザーのUIDが含まれるデータを取得
      final user = await getLoggedInUser();
      var snapshot = await FirebaseFirestore.instance.collection('friends').where('hostUid', isEqualTo: user.uid).limit(1).get();
      friendList = snapshot.docs;
      return await getFriendList(friendList);
    } on Exception catch (e) {
      logger.e('ともだち一覧の配列作成中にエラーが発生しました。');
    }
  }

  // friendList(array)に合致するユーザー一覧を追加
  Future getFriendList(friendList) async {
    logger.i('ともだち一覧データの取得開始');
    try {
      return FirebaseFirestore.instance.collection('users').where('uid', arrayContainsAny: friendList.friendsUid).snapshots();
    } on Exception catch (e) {
      logger.e('ともだち一覧のデータ取得中にエラーが発生しました。');
    }
  }

  // ユーザー個人データを取得
  Future getPersonalData() async {
    logger.i('ログイン中のユーザーデータ取得開始');
    try {
      final user = await getLoggedInUser();
      return await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: user.uid).get();
    } on Exception catch (e) {
      logger.e('ログイン中のユーザーデータ取得中にエラーが発生しました。');
    }
  }
}
