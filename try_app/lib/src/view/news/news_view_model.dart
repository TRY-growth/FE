import 'package:flutter/material.dart';

import 'package:try_app/src/model/news_model.dart';
import 'package:try_app/src/model/report_model.dart';

import 'package:try_app/src/repository/news_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsRepository newsRepository;
  List<News> newsList = [];
  ReportModel? currentReport;

  NewsViewModel({required this.newsRepository});

  Future<void> fetchAllNews() async {
    newsList = await newsRepository.fetchAllNews();
    notifyListeners();
  }

  Future<ReportModel> fetchNewsQuestion(int newsId) async {
    currentReport = await newsRepository.fetchNewsQuestion(newsId);
    notifyListeners();
    return currentReport!;
  }

  Future<ReportModel> submitAnswer(int reportId, String answer) async {
    currentReport = await newsRepository.submitAnswer(reportId, answer);
    notifyListeners();
    return currentReport!;
  }
}
