import 'package:flutter/material.dart';

import 'package:try_app/src/model/report_model.dart';

import 'package:try_app/src/model/task4_model.dart';
import 'package:try_app/src/repository/task4_repository.dart';

class Task4ViewModel extends ChangeNotifier {
  final Task4Repository task4Repository;
  Task4Question? currentQuestion;
  ReportModel? currentFeedback;

  Task4ViewModel({required this.task4Repository});

  Future<Task4Question> fetchTask4Question(int taskId) async {
    currentQuestion = await task4Repository.fetchTask4Question(taskId);
    notifyListeners();
    return currentQuestion!;
  }

  Future<ReportModel> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task4Repository.submitAnswer(taskId, answer);
    notifyListeners();
    return currentFeedback!;
  }
}
