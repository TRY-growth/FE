import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:try_app/src/model/report_model.dart';

import 'package:try_app/src/view/news/news_view_model.dart';

import 'package:try_app/src/view/test/common/loading_view.dart';
import 'package:try_app/src/view/test/common/feedback_view.dart';

class NewsLearningView extends StatelessWidget {
  final ReportModel report;

  const NewsLearningView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    final TextEditingController answerController = TextEditingController();

    void submitAnswer() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoadingView(
          future: newsViewModel.submitAnswer(
              report.reportId, answerController.text),
          nextWidget: (context, feedback) => FeedbackView(report: feedback),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("News Learning"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question: ${report.newsQuestion}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: answerController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your response',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitAnswer,
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
