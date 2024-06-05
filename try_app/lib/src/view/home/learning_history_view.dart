import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';
import 'package:try_app/src/model/report_model.dart';

class LearningHistoryView extends StatefulWidget {
  final ReportModel report;

  const LearningHistoryView({super.key, required this.report});

  @override
  _LearningHistoryViewState createState() => _LearningHistoryViewState();
}

class _LearningHistoryViewState extends State<LearningHistoryView> {
  @override
  Widget build(BuildContext context) {
    final totalFeedback = widget.report.totalFeedback;
    final detailFeedback = widget.report.detailFeedback;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning History Detail"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreCard(totalFeedback!),
            _buildOverallFeedback(totalFeedback),
            _buildTips(totalFeedback),
            _buildModifiedAnswerWithFeedback(
              widget.report.detailFeedbackModifiedAnswer!,
              detailFeedback!,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Retry logic based on taskType and taskId or newsId
                  // 적절한 경로와 인수로 Navigator.push 사용
                },
                child: const Text("Retry"),
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
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
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
                      Text(
                        feedback.overallFeedback,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildExpandableFeedbackSection(
                        "Language Use",
                        feedback.languageUseFeedback,
                      ),
                      _buildExpandableFeedbackSection(
                        "Topic Development",
                        feedback.topicDevelopmentFeedback,
                      ),
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
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
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
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
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
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.subheading,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildModifiedAnswerWithFeedback(
      String modifiedAnswer, DetailFeedback detailFeedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
              "Modified Answer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: _buildTextSpans(modifiedAnswer, detailFeedback),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 16),
        ..._buildDetailFeedbackCards(detailFeedback),
      ],
    );
  }

  List<InlineSpan> _buildTextSpans(
      String modifiedAnswer, DetailFeedback detailFeedback) {
    DiffMatchPatch dmp = DiffMatchPatch();
    List<Diff> diffs = dmp.diff('', modifiedAnswer);
    dmp.diffCleanupSemantic(diffs);

    final textSpans = <InlineSpan>[];

    for (var diff in diffs) {
      TextStyle? textStyle;
      switch (diff.operation) {
        case DIFF_INSERT:
          textStyle = const TextStyle(color: Colors.green);
          break;
        case DIFF_DELETE:
          textStyle = const TextStyle(
            color: Colors.red,
            decoration: TextDecoration.lineThrough,
          );
          break;
        case DIFF_EQUAL:
          textStyle = const TextStyle(color: Colors.black);
          break;
      }

      textSpans.add(TextSpan(text: diff.text, style: textStyle));
    }

    return textSpans;
  }

  List<Widget> _buildDetailFeedbackCards(DetailFeedback detailFeedback) {
    return detailFeedback.corrections.map((correction) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                correction.category,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Text(
                        correction.originalText,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: Text(
                            correction.correctedText,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      correction.correctionReason,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
