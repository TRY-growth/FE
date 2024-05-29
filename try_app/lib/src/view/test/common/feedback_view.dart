import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:try_app/src/model/task_feedback_model.dart';

class FeedbackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedbackDetails =
        ModalRoute.of(context)?.settings.arguments as Task1Feedback?;

    final feedbackJson = jsonDecode(feedbackDetails?.totalFeedback ?? '{}');

    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (feedbackJson != null) ...[
              _buildScoreCard(feedbackJson),
              _buildFeedbackSection("Overall Feedback",
                  feedbackJson['feedback'], 'overall_feedback'),
              _buildFeedbackSection("Language Use Feedback",
                  feedbackJson['feedback'], 'language_use_feedback'),
              _buildFeedbackSection("Topic Development Feedback",
                  feedbackJson['feedback'], 'topic_development_feedback'),
              _buildTips(feedbackJson),
            ],
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text("Go to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(Map<String, dynamic> feedbackJson) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          "Score",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "${feedbackJson['score']} / 4",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildFeedbackSection(
      String title, List<dynamic> feedbackList, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          ...feedbackList.map((feedback) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                subtitle: Text(feedback[key]),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTips(Map<String, dynamic> feedbackJson) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tips",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          ...List.generate(3, (index) {
            final tip = feedbackJson['tip${index + 1}'][0];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(tip['subheading']),
                subtitle: Text(tip['feedback']),
              ),
            );
          }),
        ],
      ),
    );
  }
}
