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
          "Microphone Test",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Describe the city you live in",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // 마이크 녹음 기능 추가 필요
          },
          child: Text("Start Recording"),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onNext,
          child: Text("Next Question"),
        ),
      ],
    );
  }
}
