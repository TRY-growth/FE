import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:try_app/src/view/test/common/feedback_view.dart';
import 'package:try_app/src/view/test/common/loading_view.dart';

import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/listening_material_widget.dart';
import 'package:try_app/src/view/test/common/question_widget.dart';

import 'package:try_app/src/view/test/task4/task4_view_model.dart';

class Task4View extends StatefulWidget {
  const Task4View({super.key});

  @override
  Task4ViewState createState() => Task4ViewState();
}

class Task4ViewState extends State<Task4View> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  void _fetchQuestion() async {
    final task4ViewModel = Provider.of<Task4ViewModel>(context, listen: false);
    await task4ViewModel.fetchTask4Question(1);
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer(String answer) async {
    final task4ViewModel = Provider.of<Task4ViewModel>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingView(
        future: task4ViewModel.submitAnswer(1, answer),
        nextWidget: (context, feedback) => FeedbackView(report: feedback),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final task4ViewModel = Provider.of<Task4ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Task 4",
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
      body: task4ViewModel.currentQuestion == null
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _currentStep == 2 ? null : _nextStep,
              steps: [
                Step(
                  title: const Text("Microphone Access"),
                  content: MicrophoneTestWidget(onNext: _nextStep),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: const Text("Lecture"),
                  content: ListeningMaterialWidget(
                    content: "4",
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: const Text("Final Question"),
                  content: QuestionWidget(
                    question: task4ViewModel.currentQuestion!.question,
                    onSubmit: _submitAnswer,
                  ),
                  isActive: _currentStep == 2,
                ),
              ],
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return _currentStep == 2
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
