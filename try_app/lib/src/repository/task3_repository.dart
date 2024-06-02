import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:try_app/src/model/task3_model.dart';
import 'package:try_app/src/model/report_model.dart';

class Task3Repository {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<Task3Question> fetchTask3Question(int taskId) async {
    final response = await http.get(Uri.parse('$baseUrl/task/3/$taskId'));

    if (response.statusCode == 200) {
      return Task3Question.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load task3 question');
    }
  }

  Future<ReportModel> submitAnswer(int taskId, String answer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/task/3/$taskId/response'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(answer),
    );

    if (response.statusCode == 200) {
      return ReportModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit answer');
    }
  }
}
