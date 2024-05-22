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
    // 여기서 로딩 화면으로 이동하고 피드백을 받기 위한 post 요청을 수행합니다.
    Navigator.of(context).pushNamed('/loading', arguments: {
      'onComplete': (feedback) {
        Navigator.of(context).pushNamed('/feedback', arguments: feedback);
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 1"),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
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
      ),
    );
  }
}
