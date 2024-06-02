import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:try_app/src/model/report_model.dart';

class HomeRepository {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<ReportModel>> fetchLearningHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/user/1/reports'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ReportModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load learning history');
    }
  }
}
