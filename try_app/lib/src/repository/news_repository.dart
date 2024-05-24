import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:try_app/src/model/news_model.dart';
import 'package:try_app/src/model/news_question_model.dart';
import 'package:try_app/src/model/news_feedback_model.dart';

class NewsRepository {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<News>> fetchAllNews() async {
    final response = await http.get(Uri.parse('$baseUrl/news/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<NewsQuestion> fetchNewsQuestion(int newsId) async {
    final response =
        await http.post(Uri.parse('$baseUrl/news/newsId=$newsId/gpt'));

    if (response.statusCode == 200) {
      return NewsQuestion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to generate question');
    }
  }

  Future<NewsFeedback> submitAnswer(int savePointId, String answer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/savepoint=$savePointId/userAnswer'),
      headers: {'Content-Type': 'application/json'}, // Content-Type 유지
      body: jsonEncode(answer), // JSON으로 인코딩된 문자열 그대로 전달
    );

    if (response.statusCode == 200) {
      return NewsFeedback.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit answer');
    }
  }
}
