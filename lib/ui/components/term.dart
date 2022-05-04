import 'package:flutter/material.dart';

class TermSectionText extends StatelessWidget {
  const TermSectionText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class TermContentText extends StatelessWidget {
  const TermContentText({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text),
    );
  }
}

class TermNumText extends StatelessWidget {
  const TermNumText({Key? key, required this.text, required this.number}) : super(key: key);
  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text("$number."),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermAlphaText extends StatelessWidget {
  const TermAlphaText({Key? key, required this.text, required this.alphabet}) : super(key: key);
  final String text;
  final String alphabet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 2, bottom: 2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(alphabet + "."),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermSubContent extends StatelessWidget {
  const TermSubContent({Key? key, required this.text, required this.alphabet}) : super(key: key);
  final String text;
  final String alphabet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 2, bottom: 2),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(alphabet + "."),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
