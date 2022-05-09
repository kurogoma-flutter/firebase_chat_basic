import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../providers/inquiry_provider.dart';

class InquiryPage extends StatelessWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<Inquiry>(
      create: (context) => Inquiry(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                context.go('/setting');
              },
            ),
            title: const Text(
              'お問合せ',
              style: TextStyle(color: Colors.black87),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 2,
          ),
          body: Container(
            width: size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'お問合せいただきありがとうございます。\nいただいた意見につきましては、今後のアプリケーション及び運営の改善点として次回のアップデートで修正できるよう努めさせていただきます。',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 50),
                const Text(
                  'お問合せ概要',
                  style: TextStyle(fontSize: 16),
                ),
                // セレクトボックスに
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: Container(), // 下線を消すため
                      // 問合せリストをドロップダウンに変換
                      items: context.read<Inquiry>().inquiryList.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        },
                      ).toList(),
                      value: context.watch<Inquiry>().genre,
                      onChanged: context.read<Inquiry>().onChangeGenre,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '返信先メールアドレス',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: TextFormField(
                      maxLines: 1,
                      maxLength: 100,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: 'sample@gmail.com',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        context.read<Inquiry>().onChangeEmail(value);
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'お問合せ内容',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      maxLines: 6,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        context.read<Inquiry>().onChangeContent(value);
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  child: Center(
                    child: SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        child: const Text(
                          '送 信',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // 送信処理 + 完了ダイアログ
                          context.read<Inquiry>().onSubmitInquiry(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          onPrimary: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
