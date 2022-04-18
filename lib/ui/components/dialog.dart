import 'package:flutter/cupertino.dart';

// エラーダイアログ
confirmDialog(String title, String text, BuildContext context) async {
  return await showCupertinoDialog<int>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('キャンセル'),
            onPressed: () => Navigator.of(context).pop(0),
          ),
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
}

// アラートダイアログ
alertDialog(String title, String text, BuildContext context) async {
  var result = await showCupertinoDialog<int>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(1),
          ),
        ],
      );
    },
  );
  return result;
}
