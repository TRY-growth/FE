import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/model/report_model.dart';
import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:try_app/src/view/test/common/loading_view.dart';
import 'package:try_app/src/view/test/common/feedback_view.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/question_widget.dart';

class NewsLearningView extends StatefulWidget {
  final ReportModel report;

  const NewsLearningView({super.key, required this.report});

  @override
  NewsLearningViewState createState() => NewsLearningViewState();
}

class NewsLearningViewState extends State<NewsLearningView> {
  int _currentStep = 0;
  final TextEditingController answerController = TextEditingController();

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer(String answer) async {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingView(
        future: newsViewModel.submitAnswer(widget.report.reportId, answer),
        nextWidget: (context, feedback) => FeedbackView(report: feedback),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Learning"),
        centerTitle: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _currentStep == 1 ? null : _nextStep,
        steps: [
          Step(
            title: const Text("Microphone Test"),
            content: MicrophoneTestWidget(onNext: _nextStep),
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text("Final Question"),
            content: QuestionWidget(
              question: widget.report.newsQuestion!,
              onSubmit: _submitAnswer,
            ),
            isActive: _currentStep == 1,
          ),
        ],
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return _currentStep == 1
              ? Container()
              : Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: details.onStepContinue,
                      child: const Text('CONTINUE'),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
