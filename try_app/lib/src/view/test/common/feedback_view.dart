import 'package:flutter/material.dart';

class FeedbackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedback = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Feedback:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(feedback),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/home");
              },
              child: Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
