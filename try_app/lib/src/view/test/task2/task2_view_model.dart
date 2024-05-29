import 'package:flutter/material.dart';
import 'package:try_app/src/model/task_feedback_model.dart';
import 'package:try_app/src/repository/task2_repository.dart';
import 'package:try_app/src/model/task2_model.dart';

class Task2ViewModel extends ChangeNotifier {
  final Task2Repository task2Repository;
  Task1Feedback? currentFeedback;
  Task2Question? currentQuestion;

  Task2ViewModel({required this.task2Repository});

  Future<void> fetchTask2Question(int taskId) async {
    currentQuestion = await task2Repository.fetchTask2Question(taskId);
    notifyListeners();
  }

  Future<void> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task2Repository.submitAnswer(taskId, answer);
    notifyListeners();
  }
}
