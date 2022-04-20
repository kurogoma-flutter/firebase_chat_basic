import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1, // 表示されるコールスタックの数
    errorMethodCount: 5, // 表示されるスタックトレースのコールスタックの数
    lineLength: 120, // 出力するログ1行の幅
    colors: true, // メッセージに色をつける
    printEmojis: true, // 絵文字を出力
    printTime: true, // タイムスタンプを出力
  ),
  output: ConsoleOutput(),
);

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      print(line);
    }
  }
}
