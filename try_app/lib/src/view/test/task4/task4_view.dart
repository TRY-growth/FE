import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/final_question_widget.dart';
import 'package:try_app/src/view/test/task4/task4_view_model.dart';

import '../common/listening_material_widget.dart';

class Task4View extends StatefulWidget {
  @override
  _Task4ViewState createState() => _Task4ViewState();
}

class _Task4ViewState extends State<Task4View> {
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
    await task4ViewModel.submitAnswer(1, answer);
    Navigator.of(context)
        .pushNamed('/loading', arguments: task4ViewModel.currentFeedback);
  }

  @override
  Widget build(BuildContext context) {
    final task4ViewModel = Provider.of<Task4ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task 4"),
      ),
      body: task4ViewModel.currentQuestion == null
          ? Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _currentStep == 2 ? null : _nextStep,
              steps: [
                Step(
                  title: Text("Microphone Test"),
                  content: MicrophoneTestWidget(onNext: _nextStep),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: Text("Listening Material"),
                  content: ListeningMaterialWidget(
                    content: task4ViewModel.currentQuestion!.lecture,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: Text("Final Question"),
                  content: FinalQuestionWidget(
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
