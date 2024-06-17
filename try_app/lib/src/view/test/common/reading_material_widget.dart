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
        const SizedBox(height: 20),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Barlow',
            letterSpacing: 0.5,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF210A3B),
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
