import 'package:flutter/material.dart';

class NewsLearningView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final newsDetails = args?['newsDetails'] as Map<String, String>?;
    final question = args?['question'] as String?;

    void _submitAnswer() {
      Navigator.of(context).pushNamed('/loading', arguments: {
        'onComplete': (feedback) {
          Navigator.of(context).pushNamed('/feedback', arguments: feedback);
        },
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("News Learning"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsDetails != null && question != null) ...[
              Text(newsDetails['content']!, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text("Based on the news, please answer the following question:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(question),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your response',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAnswer,
                child: Text("Submit"),
              ),
            ] else ...[
              Text("No learning material available."),
            ],
          ],
        ),
      ),
    );
  }
}
