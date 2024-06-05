import 'package:flutter/material.dart';
import 'package:try_app/src/model/report_model.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

class FeedbackView extends StatefulWidget {
  final ReportModel report;

  const FeedbackView({super.key, required this.report});

  @override
  FeedbackViewState createState() => FeedbackViewState();
}

class FeedbackViewState extends State<FeedbackView> {
  @override
  Widget build(BuildContext context) {
    final totalFeedback = widget.report.totalFeedback;
    final detailFeedback = widget.report.detailFeedback;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreCard(totalFeedback!),
            _buildOverallFeedback(totalFeedback),
            _buildTips(totalFeedback),
            _buildSubmissionComparison(widget.report.submitAnswer!,
                widget.report.detailFeedbackModifiedAnswer!),
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

  Widget _buildOverallFeedback(TotalFeedback totalFeedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Overall Feedback",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: totalFeedback.feedback.map((feedback) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: 366,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(feedback.overallFeedback,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      _buildExpandableFeedbackSection(
                          "Language Use", feedback.languageUseFeedback),
                      _buildExpandableFeedbackSection("Topic Development",
                          feedback.topicDevelopmentFeedback),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableFeedbackSection(String title, String feedback) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(feedback),
        ),
      ],
    );
  }

  Widget _buildTips(TotalFeedback totalFeedback) {
    List<Tip> allTips = [
      ...totalFeedback.tip1,
      ...totalFeedback.tip2,
      ...totalFeedback.tip3
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Tips",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: allTips.map((tip) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: 300,
                  height: 150, // 높이를 고정
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tip.subheading,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(tip.feedback),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmissionComparison(
      String submitAnswer, String modifiedAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Detail Feedback",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Submitted Answer",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(submitAnswer),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Modified Answer",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  PrettyDiffText(
                    oldText: submitAnswer,
                    newText: modifiedAnswer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailFeedbackSection(DetailFeedback detailFeedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ...detailFeedback.corrections.map((correction) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text("Original: ${correction.originalText}"),
              subtitle: Text(
                  "Correction: ${correction.correctedText}\nReason: ${correction.correctionReason}"),
            ),
          );
        }),
      ],
    );
  }
}

class PrettyDiffText extends StatelessWidget {
  final String oldText;
  final String newText;

  const PrettyDiffText({
    super.key,
    required this.oldText,
    required this.newText,
  });

  @override
  Widget build(BuildContext context) {
    DiffMatchPatch dmp = DiffMatchPatch();
    List<Diff> diffs = dmp.diff(oldText, newText);
    dmp.diffCleanupSemantic(diffs);

    final textSpans = <TextSpan>[];

    for (var diff in diffs) {
      TextStyle? textStyle;
      switch (diff.operation) {
        case DIFF_INSERT:
          textStyle = const TextStyle(
            color: Colors.green,
            // backgroundColor: Colors.lightGreen
          );
          break;
        case DIFF_DELETE:
          textStyle = const TextStyle(
              color: Colors.red,
              // backgroundColor: Colors.red,

              decoration: TextDecoration.lineThrough);
          break;
        case DIFF_EQUAL:
          textStyle = const TextStyle(backgroundColor: Colors.transparent);
          break;
      }
      textSpans.add(TextSpan(text: diff.text, style: textStyle));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
