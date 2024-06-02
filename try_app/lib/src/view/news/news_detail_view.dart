import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:try_app/src/model/news_model.dart';

import 'package:try_app/src/view/news/news_view_model.dart';

import 'package:try_app/src/view/test/common/loading_view.dart';
import 'package:try_app/src/view/news/news_learning_view.dart';

class NewsDetailView extends StatelessWidget {
  final News news;

  const NewsDetailView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

    void startLearning() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoadingView(
          future: newsViewModel.fetchNewsQuestion(news.newsId),
          nextWidget: (context, report) => NewsLearningView(report: report),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.newsTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              DateFormat('MMM dd, yyyy').format(DateTime.parse(news.newsDate)),
            ),
            const SizedBox(height: 20),
            Image.network(news.newsURL, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(news.newsArticle, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: startLearning,
                child: const Text("Start Learning"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
