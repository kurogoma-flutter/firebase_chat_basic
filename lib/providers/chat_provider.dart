import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/logger.dart';
import '../utils/date_methods.dart';

class ChatProvider extends ChangeNotifier {
  // 日付管理
  DateMethods date = DateMethods();
  // 取得状況
  bool isLoading = false;
  // 「あなた」ルームのチャットデータ
  String yourChatText = '';

  Future fetchYourChatData() async {
    logger.i('「あなた」のチャットデータを取得開始');
    try {
      isLoading = true;
      notifyListeners();
      var yourRoom = await FirebaseFirestore.instance.collection("yourRoom").orderBy("createdAt", descending: false).snapshots();
      isLoading = false;
      notifyListeners();
      return yourRoom;
    } on Exception catch (e) {
      logger.e('「あなた」のチャットデータ取得でエラーが発生しました。');
    }
  }

  // 「あなた」ページのテキスト変更（入力処理）
  onEditYourText(String? value) {
    if (value is String) {
      yourChatText = value;
      notifyListeners();
    }
  }

  // 「あなた」ページのデータ保存
  storeYourChatMessage(TextEditingController, controller) async {
    logger.i('あなたのチャットテキスト登録');
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (yourChatText != "") {
        await FirebaseFirestore.instance.collection('yourRoom').add({
          "uid": uid,
          "text": yourChatText,
          "imagePath": "",
          "createdAt": date.fireStoreFormat.format(DateTime.now()),
        });

        // リセット処理
        yourChatText = '';
        notifyListeners();
        controller.clear();
      }
    } on Exception catch (e) {
      isLoading = false;
      notifyListeners();
      logger.e('テキスト登録中にエラーが発生しました');
    }
  }

  // ともだち一覧用ユーザーデータ取得
  Future getUserList(BuildContext context) async {
    isLoading = true;
    logger.i('ともだち一覧を取得するための配列作成');
    try {
      List<DocumentSnapshot> friendList = [];
      // yourRoomからログインユーザーのUIDが含まれるデータを取得
      var user = await context.read<AuthProvider>().getLoggedInUser(context);
      var snapshot = await FirebaseFirestore.instance.collection('friends').where('hostUid', isEqualTo: user.uid).limit(1).get();
      friendList = snapshot.docs;
      isLoading = false;

      return await getFriendList(friendList);
    } on Exception catch (e) {
      isLoading = false;
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
  Future getPersonalData(BuildContext context) async {
    logger.i('ログイン中のユーザーデータ取得開始');
    try {
      final user = await context.read<AuthProvider>().getLoggedInUser(context);
      return await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: user.uid).get();
    } on Exception catch (e) {
      logger.e('ログイン中のユーザーデータ取得中にエラーが発生しました。');
    }
  }
}
