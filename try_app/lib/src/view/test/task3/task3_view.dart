import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/final_question_widget.dart';
import 'package:try_app/src/view/test/task3/task3_view_model.dart';

import '../common/listening_material_widget.dart';
import '../common/reading_material_widget.dart';

class Task3View extends StatefulWidget {
  @override
  _Task3ViewState createState() => _Task3ViewState();
}

class _Task3ViewState extends State<Task3View> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  void _fetchQuestion() async {
    final task3ViewModel = Provider.of<Task3ViewModel>(context, listen: false);
    await task3ViewModel.fetchTask3Question(1);
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _submitAnswer(String answer) async {
    final task3ViewModel = Provider.of<Task3ViewModel>(context, listen: false);
    await task3ViewModel.submitAnswer(1, answer);
    Navigator.of(context)
        .pushNamed('/loading', arguments: task3ViewModel.currentFeedback);
  }

  @override
  Widget build(BuildContext context) {
    final task3ViewModel = Provider.of<Task3ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task 3"),
      ),
      body: task3ViewModel.currentQuestion == null
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
                    content: task3ViewModel.currentQuestion!.passage,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: Text("Listening Material"),
                  content: ListeningMaterialWidget(
                    content: task3ViewModel.currentQuestion!.discussion,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 2,
                ),
                Step(
                  title: Text("Final Question"),
                  content: FinalQuestionWidget(
                    question: task3ViewModel.currentQuestion!.question,
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
