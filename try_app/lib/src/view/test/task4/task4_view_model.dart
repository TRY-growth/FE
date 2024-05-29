import 'package:flutter/material.dart';
import 'package:try_app/src/model/task_feedback_model.dart';
import 'package:try_app/src/model/task4_model.dart';
import 'package:try_app/src/repository/task4_repository.dart';

class Task4ViewModel extends ChangeNotifier {
  final Task4Repository task4Repository;
  Task4Question? currentQuestion;
  Task1Feedback? currentFeedback;

  Task4ViewModel({required this.task4Repository});

  Future<void> fetchTask4Question(int taskId) async {
    currentQuestion = await task4Repository.fetchTask4Question(taskId);
    notifyListeners();
  }

  Future<void> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task4Repository.submitAnswer(taskId, answer);
    notifyListeners();
  }
}
