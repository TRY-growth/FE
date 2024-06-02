import 'package:flutter/material.dart';

class ReadingMaterialWidget extends StatelessWidget {
  final String content;
  final VoidCallback onNext;

  const ReadingMaterialWidget(
      {super.key, required this.content, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
