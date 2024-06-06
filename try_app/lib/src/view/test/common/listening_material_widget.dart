import 'package:flutter/material.dart';

class ListeningMaterialWidget extends StatelessWidget {
  final String content;
  final VoidCallback onNext;

  const ListeningMaterialWidget(
      {super.key, required this.content, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // 듣기 자료 오디오 플레이어 추가 필요
        Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
