import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:try_app/src/view/test/common/feedback_view.dart';
import 'package:try_app/src/view/test/common/loading_view.dart';

import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/question_widget.dart';
import 'package:try_app/src/view/test/common/listening_material_widget.dart';
import 'package:try_app/src/view/test/common/reading_material_widget.dart';

import 'task2_view_model.dart';

class Task2View extends StatefulWidget {
  const Task2View({super.key});

  @override
  _Task2ViewState createState() => _Task2ViewState();
}

class _Task2ViewState extends State<Task2View> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  void _fetchQuestion() async {
    final task2ViewModel = Provider.of<Task2ViewModel>(context, listen: false);
    await task2ViewModel.fetchTask2Question(1);
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer(String answer) async {
    final task2ViewModel = Provider.of<Task2ViewModel>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingView(
        future: task2ViewModel.submitAnswer(1, answer),
        nextWidget: (context, feedback) => FeedbackView(report: feedback),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final task2ViewModel = Provider.of<Task2ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task 2"),
        centerTitle: true,
      ),
      body: task2ViewModel.currentQuestion == null
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _currentStep == 3 ? null : _nextStep,
              steps: [
                Step(
                  title: const Text("Microphone Test"),
                  content: MicrophoneTestWidget(onNext: _nextStep),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: const Text("Reading Material"),
                  content: ReadingMaterialWidget(
                    content: task2ViewModel.currentQuestion!.passage,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: const Text("Listening Material"),
                  content: ListeningMaterialWidget(
                      content: task2ViewModel.currentQuestion!.discussion,
                      onNext: _nextStep),
                  isActive: _currentStep == 2,
                ),
                Step(
                  title: const Text("Final Question"),
                  content: QuestionWidget(
                    question: task2ViewModel.currentQuestion!.question,
                    onSubmit: _submitAnswer,
                  ),
                  isActive: _currentStep == 3,
                ),
              ],
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return _currentStep == 3
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
