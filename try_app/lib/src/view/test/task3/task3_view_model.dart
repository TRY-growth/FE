import 'package:flutter/material.dart';

import 'package:try_app/src/model/report_model.dart';

import 'package:try_app/src/repository/task3_repository.dart';
import 'package:try_app/src/model/task3_model.dart';

class Task3ViewModel extends ChangeNotifier {
  final Task3Repository task3Repository;
  ReportModel? currentFeedback;
  Task3Question? currentQuestion;

  Task3ViewModel({required this.task3Repository});

  Future<Task3Question> fetchTask3Question(int taskId) async {
    currentQuestion = await task3Repository.fetchTask3Question(taskId);
    notifyListeners();
    return currentQuestion!;
  }

  Future<ReportModel> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task3Repository.submitAnswer(taskId, answer);
    notifyListeners();
    return currentFeedback!;
  }
}
