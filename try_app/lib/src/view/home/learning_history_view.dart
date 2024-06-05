import 'package:flutter/material.dart';
import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:try_app/src/model/report_model.dart';

class LearningHistoryView extends StatefulWidget {
  final ReportModel report;

  const LearningHistoryView({super.key, required this.report});

  @override
  LearningHistoryViewState createState() => LearningHistoryViewState();
}

class LearningHistoryViewState extends State<LearningHistoryView> {
  bool _showModifiedAnswer = true;

  @override
  Widget build(BuildContext context) {
    final totalFeedback = widget.report.totalFeedback;
    final detailFeedback = widget.report.detailFeedback;

    return Scaffold(
      appBar: AppBar(
        // title: const Text("Report"),
        // centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 0, bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreCard(totalFeedback!),
            _buildOverallFeedback(totalFeedback),
            _buildTips(totalFeedback),
            _buildDetailFeedbackHeader(),
            _buildAnswerSection(widget.report.detailFeedbackModifiedAnswer!,
                widget.report.submitAnswer!),
            ..._buildDetailFeedbackCards(detailFeedback!),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Retry logic based on taskType and taskId or newsId
                    // 적절한 경로와 인수로 Navigator.push 사용
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF008F9C),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(TotalFeedback totalFeedback) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 20),
          child: Row(
            children: const [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF008F9C),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Score',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008F9C),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF008F9C),
                ),
              ),
            ],
          ),
        ),
        _buildScoreIcons(int.parse(totalFeedback.score)),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScoreIcons(int score) {
    List<Widget> icons = [];
    for (int i = 0; i < 4; i++) {
      icons.add(Image.asset(
        'assets/images/score.png',
        color: i < score ? null : Colors.grey.shade300,
        height: 50,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons,
    );
  }

  Widget _buildOverallFeedback(TotalFeedback totalFeedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF008F9C),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Overall Feedback',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF008F9C),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF008F9C),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: totalFeedback.feedback.map((feedback) {
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 64,
                  padding: const EdgeInsets.all(16),
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
        const Center(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
          child: Row(
            children: const [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF008F9C),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Tips',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008F9C),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF008F9C),
                ),
              ),
            ],
          ),
        )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: allTips.map((tip) {
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: 250,
                  height: 300,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.subheading,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(tip.feedback, style: const TextStyle(fontSize: 14)),
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

  Widget _buildDetailFeedbackHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
          child: Row(
            children: const [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF008F9C),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Detail Feedback',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008F9C),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF008F9C),
                ),
              ),
            ],
          ),
        )),
        Center(
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: _showModifiedAnswer
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.teal,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _showModifiedAnswer = false;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Submitted Answer",
                              style: TextStyle(
                                  color: _showModifiedAnswer
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _showModifiedAnswer = true;
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Modified Answer",
                              style: TextStyle(
                                  color: _showModifiedAnswer
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerSection(String modifiedAnswer, String submittedAnswer) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_showModifiedAnswer)
            _buildModifiedAnswerWithFeedback(modifiedAnswer, submittedAnswer)
          else
            _buildSubmittedAnswer(submittedAnswer, modifiedAnswer),
        ],
      ),
    );
  }

  Widget _buildModifiedAnswerWithFeedback(
      String modifiedAnswer, String submittedAnswer) {
    final diffs = _generateDiffs(submittedAnswer, modifiedAnswer);
    final spans = <TextSpan>[];

    for (var diff in diffs) {
      if (diff.operation == DIFF_EQUAL || diff.operation == DIFF_INSERT) {
        spans.add(TextSpan(
          text: diff.text,
          style: TextStyle(
            color: diff.operation == DIFF_INSERT ? Colors.green : Colors.black,
          ),
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: spans,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmittedAnswer(String submittedAnswer, String modifiedAnswer) {
    final diffs = _generateDiffs(submittedAnswer, modifiedAnswer);
    final spans = <TextSpan>[];

    for (var diff in diffs) {
      if (diff.operation == DIFF_EQUAL || diff.operation == DIFF_DELETE) {
        spans.add(TextSpan(
          text: diff.text,
          style: TextStyle(
            color: diff.operation == DIFF_DELETE ? Colors.red : Colors.black,
          ),
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: spans,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        // const SizedBox(height: 50),
      ],
    );
  }

  List<Diff> _generateDiffs(String text1, String text2) {
    DiffMatchPatch dmp = DiffMatchPatch();
    List<Diff> diffs = dmp.diff(text1, text2);
    dmp.diffCleanupSemantic(diffs);
    return diffs;
  }

  List<InlineSpan> _buildTextSpans(List<Diff> diffs, bool isModified) {
    final textSpans = <InlineSpan>[];

    for (var diff in diffs) {
      TextStyle? textStyle;
      if (diff.operation == DIFF_INSERT) {
        textStyle = isModified
            ? const TextStyle(color: Colors.green)
            : const TextStyle(color: Colors.red);
      } else if (diff.operation == DIFF_DELETE) {
        textStyle = isModified
            ? const TextStyle(
                color: Colors.red, decoration: TextDecoration.lineThrough)
            : const TextStyle(color: Colors.green);
      } else {
        textStyle = const TextStyle(color: Colors.black);
      }

      textSpans.add(TextSpan(text: diff.text, style: textStyle));
    }

    return textSpans;
  }

  List<Widget> _buildDetailFeedbackCards(DetailFeedback detailFeedback) {
    return detailFeedback.corrections.map((correction) {
      return Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                correction.category,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            correction.correctedText,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
