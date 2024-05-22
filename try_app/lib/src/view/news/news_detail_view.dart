import 'package:flutter/material.dart';

class NewsDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsDetails =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    void _startLearning() {
      Navigator.of(context).pushNamed('/loading', arguments: {
        'onComplete': (question) {
          Navigator.of(context).pushNamed('/news_learning', arguments: {
            'newsDetails': newsDetails,
            'question': question,
          });
        },
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsDetails != null) ...[
              Image.network(newsDetails['thumbnail']!),
              SizedBox(height: 8),
              Text(newsDetails['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 8),
              Text(newsDetails['date']!, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text(newsDetails['content']!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startLearning,
                child: Text("Start Learning"),
              ),
            ] else ...[
              Text("No details available."),
            ],
          ],
        ),
      ),
    );
  }
}
