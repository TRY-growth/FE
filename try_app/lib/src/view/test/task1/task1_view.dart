import 'package:flutter/material.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/final_question_widget.dart';

class Task1View extends StatefulWidget {
  @override
  _Task1ViewState createState() => _Task1ViewState();
}

class _Task1ViewState extends State<Task1View> {
  int _currentStep = 0;

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer() {
    Navigator.of(context).pushNamed('/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 1"),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _currentStep == 1 ? null : _nextStep,
        steps: [
          Step(
            title: Text("Microphone Test"),
            content: MicrophoneTestWidget(onNext: _nextStep),
            isActive: _currentStep == 0,
          ),
          Step(
            title: Text("Final Question"),
            content: FinalQuestionWidget(
              question:
                  "Describe a city you have visited and explain why you liked it.",
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
