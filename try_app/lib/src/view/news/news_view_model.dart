import 'package:flutter/material.dart';
import 'package:try_app/src/model/news_model.dart';
import 'package:try_app/src/model/news_question_model.dart';
import 'package:try_app/src/model/news_feedback_model.dart';
import 'package:try_app/src/repository/news_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsRepository newsRepository;
  List<News> newsList = [];
  NewsQuestion? currentQuestion;
  NewsFeedback? currentFeedback;

  NewsViewModel({required this.newsRepository});

  Future<void> fetchAllNews() async {
    newsList = await newsRepository.fetchAllNews();
    notifyListeners();
  }

  Future<void> fetchNewsQuestion(int newsId) async {
    currentQuestion = await newsRepository.fetchNewsQuestion(newsId);
    notifyListeners();
  }

  Future<void> submitAnswer(int savePointId, String answer) async {
    currentFeedback = await newsRepository.submitAnswer(savePointId, answer);
    notifyListeners();
  }
}
