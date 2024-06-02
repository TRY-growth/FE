import 'package:flutter/material.dart';

import 'package:try_app/src/model/report_model.dart';

import 'package:try_app/src/model/task2_model.dart';
import 'package:try_app/src/repository/task2_repository.dart';

class Task2ViewModel extends ChangeNotifier {
  final Task2Repository task2Repository;
  ReportModel? currentFeedback;
  Task2Model? currentQuestion;

  Task2ViewModel({required this.task2Repository});

  Future<Task2Model> fetchTask2Question(int taskId) async {
    currentQuestion = await task2Repository.fetchTask2Question(taskId);
    notifyListeners();
    return currentQuestion!;
  }

  Future<ReportModel> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task2Repository.submitAnswer(taskId, answer);
    notifyListeners();
    return currentFeedback!;
  }
}
