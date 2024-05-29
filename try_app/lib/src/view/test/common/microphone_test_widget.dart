import 'package:flutter/material.dart';

class MicrophoneTestWidget extends StatelessWidget {
  final VoidCallback onNext;

  const MicrophoneTestWidget({Key? key, required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Press the button below\nto answer with voice,\nor\npress the next button\nto answer with text.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // 마이크 녹음 기능 추가 필요
          },
          child: Text("Start Recording"),
        ),
      ],
    );
  }
}
