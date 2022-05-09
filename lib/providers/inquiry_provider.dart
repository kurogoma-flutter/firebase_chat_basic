import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/logger.dart';
import '../ui/components/dialog.dart';
import '../utils/date_methods.dart';

class Inquiry extends ChangeNotifier {
  // 日付管理
  DateMethods date = DateMethods();

  // 状態管理の変数
  String genre = '総合問合せ'; // 問い合わせ種別
  String content = ''; // 問い合わせ内容
  String email = ''; // メールアドレス

  // 問合せリスト
  List<String> inquiryList = [
    '総合問合せ',
    '不適切なユーザーについて',
    '通報について',
    '削除依頼',
    '機能の修正要望について',
    '機能の追加要望について',
    '規約・ガイドラインに関する質問',
    'ガイドラインに関する質問',
  ];

  // 問い合わせジャンル
  onChangeGenre(String? e) {
    if (e is String) {
      genre = e;
      notifyListeners();
    }
  }

  // 問い合わせ本文
  onChangeContent(String? e) {
    if (e is String) {
      content = e;
      notifyListeners();
    }
  }

  // メールアドレス
  onChangeEmail(String? e) {
    if (e is String) {
      email = e;
      notifyListeners();
    }
  }

  // 問合せ送信処理（firestore）
  onSubmitInquiry(BuildContext context) async {
    // エラーメッセージ用の変数
    String errorMessage = '';
    // 問合せ概要の入力チェック
    if (genre == '') {
      errorMessage += '問合せジャンルを選択してください。\n';
    }
    // メールアドレスの入力チェック
    if (email == '') {
      errorMessage += 'メールアドレスは必須です。\n';
    } else {
      // メールアドレスの形式チェック
      if (!email.contains('@')) {
        errorMessage += 'メールアドレスの形式が正しくありません。\n';
      }
    }

    // エラーチェック => 問題なければ登録
    if (errorMessage == '') {
      try {
        // Firebase登録処理
        await FirebaseFirestore.instance.collection('inquiry').add({
          'genre': genre,
          'email': email,
          'content': content,
          'createdAt': date.fireStoreFormat.format(DateTime.now()),
        });

        // 送信完了メッセージ
        var result = await alertDialog(
          '送信完了',
          'お問合せの送信が完了しました。\n運営からの返答をお待ちください。',
          context,
        );

        // リセットしてトップへリダイレクト
        if (result == 1) {
          // リセット処理
          genre = '総合問合せ';
          email = '';
          content = '';

          return context.go('/');
        }
      } on FirebaseAuthException catch (e) {
        // ログ出力
        logger.w('問合せの送信に失敗しました。');
        // 例外用エラーダイアログ
        return await alertDialog(
          '送信エラー',
          'お問い合わせデータの送信に失敗しました。\n再度お試ししていただき送信できない場合は「sample.admin@gmail.com」宛にメールをしてください。',
          context,
        );
      }
    } else {
      // エラーメッセージ用ダイアログ
      return await alertDialog(
        '送信エラー',
        errorMessage,
        context,
      );
    }
  }
}
