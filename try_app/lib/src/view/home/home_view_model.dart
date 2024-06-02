import 'package:flutter/material.dart';
import 'package:try_app/src/model/report_model.dart';
import 'package:try_app/src/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository homeRepository;
  List<ReportModel> learningHistory = [];

  HomeViewModel({required this.homeRepository});

  Future<void> fetchLearningHistory() async {
    learningHistory = await homeRepository.fetchLearningHistory();
    notifyListeners();
  }
}
