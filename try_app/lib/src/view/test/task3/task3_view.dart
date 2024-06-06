import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:try_app/src/view/test/common/feedback_view.dart';
import 'package:try_app/src/view/test/common/loading_view.dart';

import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
import 'package:try_app/src/view/test/common/listening_material_widget.dart';
import 'package:try_app/src/view/test/common/reading_material_widget.dart';
import 'package:try_app/src/view/test/common/question_widget.dart';

import 'package:try_app/src/view/test/task3/task3_view_model.dart';

class Task3View extends StatefulWidget {
  const Task3View({super.key});

  @override
  Task3ViewState createState() => Task3ViewState();
}

class Task3ViewState extends State<Task3View> {
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoadingView(
        future: task3ViewModel.submitAnswer(1, answer),
        nextWidget: (context, feedback) => FeedbackView(report: feedback),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final task3ViewModel = Provider.of<Task3ViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Task 3",
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
      body: task3ViewModel.currentQuestion == null
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _currentStep == 3 ? null : _nextStep,
              steps: [
                Step(
                  title: const Text("Microphone Access"),
                  content: MicrophoneTestWidget(onNext: _nextStep),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: const Text("Passage"),
                  content: ReadingMaterialWidget(
                    content: task3ViewModel.currentQuestion!.passage,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: const Text("Discussion"),
                  content: ListeningMaterialWidget(
                    content: task3ViewModel.currentQuestion!.discussion,
                    onNext: _nextStep,
                  ),
                  isActive: _currentStep == 2,
                ),
                Step(
                  title: const Text("Question"),
                  content: QuestionWidget(
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
