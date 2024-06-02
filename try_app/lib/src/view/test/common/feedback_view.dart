import 'package:flutter/material.dart';

import 'package:try_app/src/model/report_model.dart';

class FeedbackView extends StatelessWidget {
  final ReportModel report;

  const FeedbackView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final totalFeedback = report.totalFeedback;
    final detailFeedback = report.detailFeedback;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Submitted Answer",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(report.submitAnswer!),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Modified Answer",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(report.detailFeedbackModifiedAnswer!),
              ),
            ),
            const SizedBox(height: 16),
            _buildScoreCard(totalFeedback!),
            _buildFeedbackSection("Overall Feedback", totalFeedback.feedback,
                (feedback) => feedback.overallFeedback),
            _buildFeedbackSection(
                "Language Use Feedback",
                totalFeedback.feedback,
                (feedback) => feedback.languageUseFeedback),
            _buildFeedbackSection(
                "Topic Development Feedback",
                totalFeedback.feedback,
                (feedback) => feedback.topicDevelopmentFeedback),
            _buildTips(totalFeedback),
            _buildDetailFeedbackSection(detailFeedback!),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text("Go to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(TotalFeedback totalFeedback) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: const Text(
          "Score",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "${totalFeedback.score} / 4",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildFeedbackSection(String title, List<FeedbackDetail> feedbackList,
      String Function(FeedbackDetail) feedbackExtractor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ...feedbackList.map((feedback) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                subtitle: Text(feedbackExtractor(feedback)),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTips(TotalFeedback totalFeedback) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tips",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ...totalFeedback.tip1.map((tip) {
            return _buildTipCard(tip);
          }),
          ...totalFeedback.tip2.map((tip) {
            return _buildTipCard(tip);
          }),
          ...totalFeedback.tip3.map((tip) {
            return _buildTipCard(tip);
          }),
        ],
      ),
    );
  }

  Widget _buildTipCard(Tip tip) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(tip.subheading),
        subtitle: Text(tip.feedback),
      ),
    );
  }

  Widget _buildDetailFeedbackSection(DetailFeedback detailFeedback) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Detail Feedback",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ...detailFeedback.corrections.map((correction) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(correction.originalText),
                subtitle: Text(
                    "Correction: ${correction.correctedText}\nReason: ${correction.correctionReason}"),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
