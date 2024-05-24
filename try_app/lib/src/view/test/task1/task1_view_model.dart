import 'package:flutter/material.dart';
import 'package:try_app/src/model/task1_feedback_model.dart';
import 'package:try_app/src/repository/task1_repository.dart';
import 'package:try_app/src/model/task1_question_model.dart';

class Task1ViewModel extends ChangeNotifier {
  final Task1Repository task1Repository;
  Task1Feedback? currentFeedback;
  Task1Question? currentQuestion;

  Task1ViewModel({required this.task1Repository});

  Future<void> fetchTask1Question(int task1Id) async {
    currentQuestion = await task1Repository.fetchTask1Question(task1Id);
    notifyListeners();
  }

  Future<void> submitAnswer(int task1Id, String answer) async {
    currentFeedback = await task1Repository.submitAnswer(task1Id, answer);
    notifyListeners();
  }
}
