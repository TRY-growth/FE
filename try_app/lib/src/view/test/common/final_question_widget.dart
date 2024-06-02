import 'package:flutter/material.dart';

class FinalQuestionWidget extends StatelessWidget {
  final String question;
  final void Function(String) onSubmit;

  const FinalQuestionWidget(
      {super.key, required this.question, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Column(
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your response',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            onSubmit(controller.text);
          },
          child: const Text("Submit Answer"),
        ),
      ],
    );
  }
}
