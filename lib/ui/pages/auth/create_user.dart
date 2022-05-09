import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/authentication.dart';
import '../../../providers/logger.dart';
import '../../components/dialog.dart';

/// ページ仕様
/// 1. メールアドレスとパスワードで登録できる ✔
/// 2. パスワードの非表示はオンオフできる
/// 3. ログイン画面に遷移できる ✔
class RegistUserWithMail extends StatefulWidget {
  const RegistUserWithMail({Key? key}) : super(key: key);

  @override
  State<RegistUserWithMail> createState() => _RegistUserWithMailState();
}

class _RegistUserWithMailState extends State<RegistUserWithMail> {
  // 入力されたメールアドレスx
  String newUserEmail = '';
  // 入力されたパスワード
  String newUserPassword = '';
  // エラーメッセージなどの格納先
  String infoText = '';
  // パスワードの表示非表示
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '新規ユーザー登録',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ユーザー情報',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction, // 入力時バリデーション
                cursorColor: Colors.blueAccent,
                decoration: const InputDecoration(
                  focusColor: Colors.red,
                  labelText: 'ユーザー名',
                  hintText: 'ユーザー名',
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "入力してください";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction, // 入力時バリデーション
                cursorColor: Colors.blueAccent,
                decoration: const InputDecoration(
                  focusColor: Colors.red,
                  labelText: 'メールアドレス',
                  hintText: 'sample@gmail.com',
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "入力してください";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction, // 入力時バリデーション
                cursorColor: Colors.blueAccent,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  focusColor: Colors.red,
                  labelText: 'パスワード',
                  hintText: 'Enter Your Password',
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                  border: const OutlineInputBorder(borderSide: BorderSide()),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "入力してください";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // メール/パスワードでユーザー登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result = await auth.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );
                    setState(() {
                      infoText = "登録されました";
                    });

                    /// そのままログインしてHomeへ遷移
                    final UserCredential login = await auth.signInWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );
                    // ログインに成功した場合
                    final User user = login.user!;
                    setState(() {
                      infoText = "ログイン!";
                    });
                    // ホームに画面遷移
                    return context.go('/');
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

                    return alertDialog('登録エラー', message, context);
                  }
                },
                child: const Text(
                  '新規登録',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  onPrimary: Colors.white,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'SNSで登録',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /// Google認証
                  GestureDetector(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEFEFE),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Image.asset('assets/images/google-icon.png'),
                    ),
                    onTap: () async {
                      try {
                        final userCredential = await signInWithGoogle();
                        if (userCredential!.user != null) {
                          context.go('/');
                        } else {
                          context.go('error');
                        }
                      } on FirebaseAuthException catch (e) {
                        print('FirebaseAuthException');
                        print('${e.code}');
                        logger.w('ログインに失敗しました。');
                      } on Exception catch (e) {
                        print('Other Exception');
                        print('${e.toString()}');
                        logger.w('ログインに失敗しました。');
                      }
                    },
                  ),

                  /// LINE認証
                  GestureDetector(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEFEFE),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Image.asset(
                        'assets/images/line-round-default.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {},
                  ),

                  /// Twitter認証
                  GestureDetector(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEFEFE),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Image.asset(
                        'assets/images/twitter.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text(
                'ログインはこちら',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
