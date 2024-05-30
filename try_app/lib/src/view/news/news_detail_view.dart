import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:try_app/src/model/news_model.dart';
import 'package:intl/intl.dart';

class NewsDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsDetails = ModalRoute.of(context)?.settings.arguments as News;
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

    void _startLearning() async {
      await newsViewModel.fetchNewsQuestion(newsDetails.newsId);
      Navigator.of(context).pushNamed('/news_learning',
          arguments: newsViewModel.currentQuestion);
    }

    return Scaffold(
      appBar: AppBar(
          // title: Text("News Detail"),
          ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network("https://via.placeholder.com/150"),
            // SizedBox(height: 8),
            Text(newsDetails.newsTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 12),
            Text(
              DateFormat('MMM dd, yyyy')
                  .format(DateTime.parse(newsDetails.newsDate)),
            ),
            SizedBox(height: 20),
            Image.network(newsDetails.newsURL, fit: BoxFit.cover),

            SizedBox(height: 20),
            Text(newsDetails.newsArticle, style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _startLearning,
                child: Text("Start Learning"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
