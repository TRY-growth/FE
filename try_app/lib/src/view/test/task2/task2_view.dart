import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/final_question_widget.dart';
import 'package:try_app/src/view/test/common/listening_material_widget.dart';
import 'package:try_app/src/view/test/common/reading_material_widget.dart';

import 'task2_view_model.dart';

class Task2View extends StatefulWidget {
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

  // void _submitAnswer() {
  //   Navigator.of(context).pushNamed('/loading');
  // }

  void _submitAnswer(String answer) async {
    final task2ViewModel = Provider.of<Task2ViewModel>(context, listen: false);
    await task2ViewModel.submitAnswer(1, answer);
    Navigator.of(context)
        .pushNamed('/loading', arguments: task2ViewModel.currentFeedback);
  }

  @override
  Widget build(BuildContext context) {
    final task2ViewModel = Provider.of<Task2ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task 2"),
      ),
      body: task2ViewModel.currentQuestion == null
          ? Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _currentStep == 3 ? null : _nextStep,
              steps: [
                Step(
                  title: Text("Microphone Test"),
                  content: MicrophoneTestWidget(onNext: _nextStep),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: Text("Reading Material"),
                  content: ReadingMaterialWidget(
                    content: task2ViewModel.currentQuestion!.passage,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: Text("Listening Material"),
                  content: ListeningMaterialWidget(
                      content: task2ViewModel.currentQuestion!.passage,
                      onNext: _nextStep),
                  isActive: _currentStep == 2,
                ),
                Step(
                  title: Text("Final Question"),
                  content: FinalQuestionWidget(
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
