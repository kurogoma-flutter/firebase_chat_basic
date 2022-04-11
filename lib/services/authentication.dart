import 'package:chat_app_basic/utils/date_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ログインユーザーの情報を取得
Future getLoggedInUser() async {
  return FirebaseAuth.instance.currentUser;
}

// ログイン処理（メール）
Future login(String email, String password) async {
  try {
    // メール/パスワードでログイン
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // ログインに成功した場合
    final User user = result.user!;
    return 'success';
  } on FirebaseAuthException catch (e) {
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

    return message;
  }
}

// ユーザー作成（メール）
Future registWithEmail(String userName, String comment, String email, String password) async {
  try {
    // メール/パスワードでユーザー登録
    final FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    /// そのままログインしてHomeへ遷移
    final UserCredential login = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // ログインに成功した場合
    final User user = login.user!;
    // usersコレクションにも追加
    DateMethods date = DateMethods();
    await FirebaseFirestore.instance.collection('users').add({
      'uid': user.uid,
      'userName': userName,
      'comment': comment,
      'iconPath': '',
      'createAt': date.now,
    });
    return 'success';
  } on FirebaseAuthException catch (e) {
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
    return message;
  }
}
