import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/test/task1/task1_view_model.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/question_widget.dart';
import 'package:try_app/src/view/test/common/loading_view.dart';
import 'package:try_app/src/view/test/common/feedback_view.dart';

class Task1View extends StatefulWidget {
  const Task1View({super.key});

  @override
  Task1ViewState createState() => Task1ViewState();
}

class Task1ViewState extends State<Task1View> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  void _fetchQuestion() async {
    final task1ViewModel = Provider.of<Task1ViewModel>(context, listen: false);
    await task1ViewModel.fetchTask1Question(1);
    setState(() {});
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer(String answer) async {
    final task1ViewModel = Provider.of<Task1ViewModel>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingView(
        future: task1ViewModel.submitAnswer(1, answer),
        nextWidget: (context, feedback) => FeedbackView(report: feedback),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final task1ViewModel = Provider.of<Task1ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Task 1",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF210A3B),
            fontFamily: 'Merriweather',
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: task1ViewModel.currentQuestion == null
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _currentStep == 1 ? null : _nextStep,
              steps: [
                Step(
                  title: const Text("Microphone Access"),
                  content: MicrophoneTestWidget(
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: const Text("Question"),
                  content: QuestionWidget(
                    question: task1ViewModel.currentQuestion!.question,
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
