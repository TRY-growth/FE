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
          "Reading Material",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          content,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onNext,
          child: Text("Next"),
        ),
      ],
    );
  }
}
