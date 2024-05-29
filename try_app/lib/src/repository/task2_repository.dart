import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:try_app/src/model/task_feedback_model.dart';
import 'package:try_app/src/model/task2_model.dart';

class Task2Repository {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<Task2Question> fetchTask2Question(int taskId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/task/2/taskId=$taskId'));

    if (response.statusCode == 200) {
      return Task2Question.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load task2 question');
    }
  }

  Future<Task1Feedback> submitAnswer(int taskId, String answer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/task/2/submit_par/taskId=$taskId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userAnswer': answer}),
    );

    if (response.statusCode == 200) {
      return Task1Feedback.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit answer');
    }
  }
}
