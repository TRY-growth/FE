import 'package:flutter/material.dart';
import 'package:try_app/src/model/task_feedback_model.dart';
import 'package:try_app/src/repository/task1_repository.dart';
import 'package:try_app/src/model/task1_model.dart';

class Task1ViewModel extends ChangeNotifier {
  final Task1Repository task1Repository;
  Task1Feedback? currentFeedback;
  Task1Question? currentQuestion;

  Task1ViewModel({required this.task1Repository});

  Future<void> fetchTask1Question(int taskId) async {
    currentQuestion = await task1Repository.fetchTask1Question(taskId);
    notifyListeners();
  }

  Future<void> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task1Repository.submitAnswer(taskId, answer);
    notifyListeners();
  }
}
