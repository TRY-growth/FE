import 'package:flutter/material.dart';

import 'package:try_app/src/model/task1_model.dart';
import 'package:try_app/src/model/report_model.dart';

import 'package:try_app/src/repository/task1_repository.dart';

class Task1ViewModel extends ChangeNotifier {
  final Task1Repository task1Repository;
  ReportModel? currentFeedback;
  Task1Model? currentQuestion;

  Task1ViewModel({required this.task1Repository});

  Future<Task1Model> fetchTask1Question(int taskId) async {
    currentQuestion = await task1Repository.fetchTask1Question(taskId);
    notifyListeners();
    return currentQuestion!;
  }

  Future<ReportModel> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task1Repository.submitAnswer(taskId, answer);
    notifyListeners();
    return currentFeedback!;
  }
}
