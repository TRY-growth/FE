import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  final VoidCallback onComplete;

  const FeedbackWidget({Key? key, required this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Feedback",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Thank you for completing the test. Here is your feedback.",
          style: TextStyle(fontSize: 18),
        ),
        // 피드백 내용 추가 필요
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onComplete,
          child: Text("Go to Home"),
        ),
      ],
    );
  }
}
