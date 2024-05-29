import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:try_app/src/model/task_feedback_model.dart';
import 'package:try_app/src/model/task1_model.dart';

class Task1Repository {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<Task1Question> fetchTask1Question(int task1Id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/task/1/taskId=$task1Id'));

    if (response.statusCode == 200) {
      return Task1Question.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load task1 question');
    }
  }

  Future<Task1Feedback> submitAnswer(int taskId, String answer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/task/1/submit_par/taskId=$taskId'),
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
