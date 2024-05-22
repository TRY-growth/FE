import 'package:flutter/material.dart';

class FinalQuestionWidget extends StatelessWidget {
  final String question;
  final VoidCallback onSubmit;

  const FinalQuestionWidget(
      {Key? key, required this.question, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Final Question",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          question,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your response',
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text("Submit Answer"),
        ),
      ],
    );
  }
}
