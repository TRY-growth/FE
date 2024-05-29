import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/final_question_widget.dart';
import 'package:try_app/src/view/test/task1/task1_view_model.dart';

class Task1View extends StatefulWidget {
  @override
  _Task1ViewState createState() => _Task1ViewState();
}

class _Task1ViewState extends State<Task1View> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  void _fetchQuestion() async {
    final task1ViewModel = Provider.of<Task1ViewModel>(context, listen: false);
    await task1ViewModel.fetchTask1Question(1);
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer(String answer) async {
    final task1ViewModel = Provider.of<Task1ViewModel>(context, listen: false);
    await task1ViewModel.submitAnswer(1, answer);
    Navigator.of(context)
        .pushNamed('/loading', arguments: task1ViewModel.currentFeedback);
  }

  @override
  Widget build(BuildContext context) {
    final task1ViewModel = Provider.of<Task1ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task 1"),
      ),
      body: task1ViewModel.currentQuestion == null
          ? Center(child: CircularProgressIndicator())
          : Stepper(
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
