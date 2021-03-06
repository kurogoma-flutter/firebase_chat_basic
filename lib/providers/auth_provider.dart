import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/logger.dart';
import '../ui/components/dialog.dart';
import '../utils/date_methods.dart';

class AuthProvider extends ChangeNotifier {
  // 日付管理
  DateMethods date = DateMethods();

  /** 状態管理の変数 **/

  // 新規登録用
  String userName = '';
  String newUserEmail = '';
  String newUserPassword = '';
  // ログイン用
  String loginUserEmail = '';
  String loginUserPassword = '';
  // 再設定用
  String resetEmail = '';
  // パスワードの表示非表示
  bool isObscure = true;

  /** テキスト入力関連 **/
  onChangeUserName(String? value) {
    if (value is String) {
      userName = value;
      notifyListeners();
    }
  }

  onChangeNewEmail(String? value) {
    if (value is String) {
      newUserEmail = value;
      notifyListeners();
    }
  }

  onChangeNewPassword(String? value) {
    if (value is String) {
      newUserPassword = value;
      notifyListeners();
    }
  }

  onChangeLoginEmail(String? value) {
    if (value is String) {
      loginUserEmail = value;
      notifyListeners();
    }
  }

  onChangeLoginPassword(String? value) {
    if (value is String) {
      loginUserPassword = value;
      notifyListeners();
    }
  }

  onChangeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  /// ユーザー認証関連

  // ログインユーザー情報の取得（メールのみ）
  getLoggedInUser(BuildContext context) async {
    // ログ出力
    logger.i('ログインユーザーデータの取得を開始');

    try {
      // ログインユーザーのデータを返す
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      // エラー処理
      String message = 'ログイン中のユーザーデータを取得できませんでした。';
      logger.w(message);
      return await alertDialog('内部処理エラー', message, context);
    }
  }

  /// メール認証：ユーザー登録
  Future registWithEmail(BuildContext context) async {
    // ログ出力
    logger.i('新規ユーザーデータ作成');
    try {
      // メール/パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: newUserEmail,
        password: newUserPassword,
      );

      /// そのままログインしてHomeへ遷移
      final UserCredential login = await auth.signInWithEmailAndPassword(
        email: newUserEmail,
        password: newUserPassword,
      );
      // ログインに成功したか識別
      final User user = login.user!;
      // usersコレクションにも追加
      try {
        await FirebaseFirestore.instance.collection('users').add({
          'uid': user.uid,
          'userName': userName,
          'comment': '',
          'iconPath': '',
          'createAt': date.fireStoreFormat.format(DateTime.now()),
        });

        return context.go('/');
      } on Exception catch (e) {
        String message = 'ユーザー登録に失敗しました。';
        logger.w(message);
        return await alertDialog('認証エラー', message, context);
      }
    } on FirebaseAuthException catch (e) {
      logger.w('新規ユーザー登録に失敗しました。');
      // ログインに失敗した場合
      String message = '';
      // エラーコード別処理
      switch (e.code) {
        case 'invalid-email':
          message = 'メールアドレスが不正です。';
          break;
        case 'wrong-password':
          message = 'パスワードが違います。';
          break;
        case 'user-disabled':
          message = '指定されたユーザーは無効です。';
          break;
        case 'user-not-found':
          message = '指定されたユーザーは存在しません。';
          break;
        case 'operation-not-allowed':
          message = '指定されたユーザーはこの操作を許可していません。';
          break;
        case 'too-many-requests':
          message = '複数回リクエストが発生しました。';
          break;
        case 'email-already-exists':
          message = '指定されたメールアドレスは既に使用されています。';
          break;
        case 'internal-error':
          message = '内部処理エラーが発生しました。';
          break;
        default:
          message = '予期せぬエラーが発生しました。';
      }
      return await alertDialog('登録処理に失敗しました。', message, context);
    }
  }

  /// メール認証：ユーザーログイン
  Future login(BuildContext context) async {
    logger.i('メールログイン開始');
    try {
      // メール/パスワードでログイン
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: loginUserEmail,
        password: loginUserPassword,
      );
      // ログインに成功した場合
      final User user = result.user!;

      return context.go('/');
    } on FirebaseAuthException catch (e) {
      logger.w('ログインに失敗しました。');
      // ログインに失敗した場合
      String message = '';
      // エラーコード別処理
      switch (e.code) {
        case 'invalid-email':
          message = 'メールアドレスが不正です。';
          break;
        case 'wrong-password':
          message = 'パスワードが違います。';
          break;
        case 'user-disabled':
          message = '指定されたユーザーは無効です。';
          break;
        case 'user-not-found':
          message = '指定されたユーザーは存在しません。';
          break;
        case 'operation-not-allowed':
          message = '指定されたユーザーはこの操作を許可していません。';
          break;
        case 'too-many-requests':
          message = '複数回リクエストが発生しました。';
          break;
        case 'email-already-exists':
          message = '指定されたメールアドレスは既に使用されています。';
          break;
        case 'internal-error':
          message = '内部処理エラーが発生しました。';
          break;
        default:
          message = '予期せぬエラーが発生しました。';
      }

      return await alertDialog('認証エラー', message, context);
    }
  }

  /// サインアウト処理
  Future signOut(BuildContext context) async {
    logger.i('サインアウト開始');
    try {
      var result = await confirmDialog('認証チェック', 'ログアウトしますか？', context);
      if (result == 1) {
        // ログアウト => ログインへ遷移
        await FirebaseAuth.instance.signOut();
        context.go('/login');
      }
    } on FirebaseAuthException catch (e) {
      String message = 'サインアウトに失敗しました';
      logger.w(message);
      return await alertDialog('認証エラー', message, context);
    }
  }

  // パスワード再設定メール
  Future sendPasswordResetEmail(BuildContext context) async {
    logger.i('パスワード再設定通知開始');
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmail);
      // 成功したダイアログ
      return await alertDialog('確認ダイアログ', '登録したメールアドレスに再設定用のメールを送信しました。', context);
    } on FirebaseAuthException catch (e) {
      String message = '再設定通知の送信に失敗しました。';
      logger.w(message);
      return await alertDialog('エラーダイアログ', message, context);
    }
  }

  // 退会処理
  Future deleteUser(BuildContext context) async {
    try {
      // 退会処理
      var result = confirmDialog('確認ダイアログ', '削除してもよろしいですか？', context);
      User? user = FirebaseAuth.instance.currentUser;
      if (result == 1) {
        await user!.delete();
        // usersコレクションからも削除する
        var document = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: user.uid).get();
        await FirebaseFirestore.instance.collection('users').doc(document.docs.toString()).delete();
        // 全て削除したらログインページへ遷移する
        context.go('/login');
      }
    } on FirebaseAuthException catch (e) {
      String message = '退会処理に失敗しました。';
      logger.w(message);
      return await alertDialog('認証エラー', message, context);
    }
  }

  /// ================ Google サインイン ================ ///
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      // 認証フローのトリガー
      final googleUser = await GoogleSignIn(scopes: [
        'email',
      ]).signIn();
      // リクエストから、認証情報を取得
      final googleAuth = await googleUser?.authentication;
      // クレデンシャルを新しく作成
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // サインインしたら、UserCredentialを返す
      return FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      String message = 'Googleサインインに失敗しました。';
      logger.w(message);
      return await alertDialog('認証エラー', message, context);
    }
    return null;
  }

  // Googleのサインアウト
  Future signOutGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      String message = 'サインアウトに失敗しました（Google）';
      logger.w(message);
      return await alertDialog('認証エラー', message, context);
    }
  }

  /// ================ LINE サインイン ================ ///

  Future signInWithLine(BuildContext context) async {
    try {
      final result = await LineSDK.instance.login();

      /// ライン情報からユーザー情報を取得。usersコレクションにデータがなければ新規追加
      String userName = result.userProfile!.displayName;
      String uid = result.userProfile!.userId;
      String? iconPath = result.userProfile!.pictureUrl;
      List<DocumentSnapshot> userInfo = [];
      final users = await FirebaseFirestore.instance.collection('users').where('userName', isEqualTo: userName).limit(1).get();
      userInfo = users.docs;
      if (userInfo.isEmpty) {
        try {
          await FirebaseFirestore.instance.collection('users').add({
            'uid': uid,
            'userName': '',
            'iconPath': '',
            'comment': '',
          });
        } on FirebaseAuthException catch (e) {
          logger.w('LINE認証（users追加）に失敗しました。');
        }
      }
    } on PlatformException catch (e) {
      String message = 'LINE認証（ログイン）に失敗しました';
      logger.w(message);
      return await alertDialog('内部処理エラー', message, context);
    }
  }

  Future signOutFromLine() async {
    try {
      await LineSDK.instance.logout();
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future getLineAuthUserInfo() async {
    try {
      final result = await LineSDK.instance.getProfile();
      // user id -> result.userId
      // user name -> result.displayName
      // user avatar -> result.pictureUrl
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
