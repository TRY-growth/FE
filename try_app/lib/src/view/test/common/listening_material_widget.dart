import 'package:flutter/material.dart';

class ListeningMaterialWidget extends StatelessWidget {
  final VoidCallback onNext;

  const ListeningMaterialWidget({Key? key, required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Listening Material",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        // 듣기 자료 오디오 플레이어 추가 필요
        ElevatedButton(
          onPressed: onNext,
          child: Text("Next"),
        ),
      ],
    );
  }
}
