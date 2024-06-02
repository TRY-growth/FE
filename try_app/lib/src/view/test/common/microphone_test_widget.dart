import 'package:flutter/material.dart';

class MicrophoneTestWidget extends StatelessWidget {
  final VoidCallback onNext;

  const MicrophoneTestWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Press the button below\nto answer with voice,\nor\npress the next button\nto answer with text.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // 마이크 녹음 기능 추가 필요
          },
          child: const Text("Start Recording"),
        ),
      ],
    );
  }
}
