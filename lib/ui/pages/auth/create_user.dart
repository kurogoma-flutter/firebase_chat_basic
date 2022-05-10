import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/authentication.dart';
import '../../../services/logger.dart';
import '../../components/dialog.dart';

class RegistUserWithMail extends StatefulWidget {
  const RegistUserWithMail({Key? key}) : super(key: key);

  @override
  State<RegistUserWithMail> createState() => _RegistUserWithMailState();
}

class _RegistUserWithMailState extends State<RegistUserWithMail> {

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
                  context.read<AuthProvider>().onChangeUserName(value);
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
                  contest.read<AuthProvider>().onChangeNewEmail(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "入力してください";
                  }
                  if(!value.contains('@')){
                    return '不適切な形式です。';
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
                obscureText: context.read<AuthProvider>().isObscure,
                decoration: InputDecoration(
                  focusColor: Colors.red,
                  labelText: 'パスワード',
                  hintText: 'Enter Your Password',
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
                  border: const OutlineInputBorder(borderSide: BorderSide()),
                  suffixIcon: IconButton(
                    icon: Icon(context.read<AuthProvider>().isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      context.read<AuthProvider>().onChangeObscure();
                    },
                  ),
                ),
                maxLines: 1,
                onChanged: (value) {
                  context.read<AuthProvider>().onChangeNewPassword(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '入力してください';
                  }
                  if(value.length <= 5){
                    return 'パスワードは6文字以上で設定してください。'
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
                  // 登録処理
                  await context.read<AuthProvider>().registWithEmail(context);
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
                      await context.read<AuthProvider>().signInWithGoogle(context);
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
                    onTap: () async{
                      await context.read<AuthProvider>().signInWithLine(context);
                    },
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
                    onTap: () {
                      // 未実装
                    },
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
