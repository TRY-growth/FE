import 'package:flutter/material.dart';

class ReadingMaterialWidget extends StatelessWidget {
  final String content;
  final VoidCallback onNext;

  const ReadingMaterialWidget(
      {Key? key, required this.content, required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          content,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
