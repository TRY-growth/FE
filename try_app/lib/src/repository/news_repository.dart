import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:try_app/src/model/news_model.dart';
import 'package:try_app/src/model/report_model.dart';

class NewsRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<NewsModel>> fetchAllNews() async {
    final response = await http.get(Uri.parse('$baseUrl/news'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<ReportModel> fetchNewsQuestion(int newsId) async {
    final response =
        await http.post(Uri.parse('$baseUrl/news/$newsId/question'));

    if (response.statusCode == 200) {
      return ReportModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to generate question');
    }
  }

  Future<ReportModel> submitAnswer(int reportId, String answer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/$reportId/response'),
      headers: {'Content-Type': 'application/json'},
      body: answer,
    );

    if (response.statusCode == 200) {
      return ReportModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit answer');
    }
  }
}
