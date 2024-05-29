import 'package:flutter/material.dart';
import 'package:try_app/src/model/task_feedback_model.dart';
import 'package:try_app/src/repository/task3_repository.dart';
import 'package:try_app/src/model/task3_model.dart';

class Task3ViewModel extends ChangeNotifier {
  final Task3Repository task3Repository;
  Task1Feedback? currentFeedback;
  Task3Question? currentQuestion;

  Task3ViewModel({required this.task3Repository});

  Future<void> fetchTask3Question(int taskId) async {
    currentQuestion = await task3Repository.fetchTask3Question(taskId);
    notifyListeners();
  }

  Future<void> submitAnswer(int taskId, String answer) async {
    currentFeedback = await task3Repository.submitAnswer(taskId, answer);
    notifyListeners();
  }
}
