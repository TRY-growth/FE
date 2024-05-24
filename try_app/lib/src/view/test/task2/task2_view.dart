// import 'package:flutter/material.dart';
// import 'package:try_app/src/view/test/common/microphone_test_widget.dart';
// import 'package:try_app/src/view/test/common/final_question_widget.dart';
// import 'package:try_app/src/view/test/common/listening_material_widget.dart';
// import 'package:try_app/src/view/test/common/reading_material_widget.dart';

// class Task2View extends StatefulWidget {
//   @override
//   _Task2ViewState createState() => _Task2ViewState();
// }

// class _Task2ViewState extends State<Task2View> {
//   int _currentStep = 0;

//   void _nextStep() {
//     setState(() {
//       _currentStep++;
//     });
//   }

//   void _submitAnswer() {
//     Navigator.of(context).pushNamed('/loading');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Task 2"),
//       ),
//       body: Stepper(
//         currentStep: _currentStep,
//         onStepContinue: _currentStep == 3 ? null : _nextStep,
//         steps: [
//           Step(
//             title: Text("Microphone Test"),
//             content: MicrophoneTestWidget(onNext: _nextStep),
//             isActive: _currentStep == 0,
//           ),
//           Step(
//             title: Text("Reading Material"),
//             content: ReadingMaterialWidget(
//               content: "This is a reading material.",
//               onNext: _nextStep,
//             ),
//             isActive: _currentStep == 1,
//           ),
//           Step(
//             title: Text("Listening Material"),
//             content: ListeningMaterialWidget(onNext: _nextStep),
//             isActive: _currentStep == 2,
//           ),
//           Step(
//             title: Text("Final Question"),
//             content: FinalQuestionWidget(
//               question:
//                   "Based on the reading and listening materials, describe the main idea and how they are related.",
//               onSubmit: _submitAnswer,
//             ),
//             isActive: _currentStep == 3,
//           ),
//         ],
//         controlsBuilder: (BuildContext context, ControlsDetails details) {
//           return _currentStep == 3
//               ? Container()
//               : Row(
//                   children: <Widget>[
//                     TextButton(
//                       onPressed: details.onStepContinue,
//                       child: const Text('CONTINUE'),
//                     ),
//                   ],
//                 );
//         },
//       ),
//     );
//   }
// }
