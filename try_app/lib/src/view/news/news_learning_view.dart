import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:try_app/src/model/news_question_model.dart';

class NewsLearningView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as NewsQuestion?;
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    final TextEditingController answerController = TextEditingController();

    void _submitAnswer() async {
      Navigator.of(context).pushNamed('/loading');
      await newsViewModel.submitAnswer(
          args!.newsSavePointId, answerController.text);
      Navigator.of(context).pushReplacementNamed('/news_feedback',
          arguments: newsViewModel.currentFeedback);
    }

    return Scaffold(
      appBar: AppBar(
          // title: Text("News Learning"),
          ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (args != null) ...[
              Text(
                "Question: ${args.gptGeneratedQuestion}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              TextField(
                controller: answerController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your response',
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitAnswer,
                  child: Text("Submit"),
                ),
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
