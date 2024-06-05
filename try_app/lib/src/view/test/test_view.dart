import 'package:flutter/material.dart';

import 'package:try_app/src/view/test/task1/task1_view.dart';
import 'package:try_app/src/view/test/task2/task2_view.dart';
import 'package:try_app/src/view/test/task3/task3_view.dart';
import 'package:try_app/src/view/test/task4/task4_view.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF210A3B);
    const subHeaderColor = Color(0xFF008F9C);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'Task 1',
                      'Evaluate and express your preference between two options.',
                      const Task1View(),
                      textColor,
                      subHeaderColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'Task 2',
                      'Respond to a campus situation with your solutions.',
                      const Task2View(),
                      textColor,
                      subHeaderColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'Task 3',
                      'Discuss an academic topic from a lecture or reading.',
                      const Task3View(),
                      textColor,
                      subHeaderColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'Task 4',
                      'Synthesize information from multiple sources.',
                      const Task4View(),
                      textColor,
                      subHeaderColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, String title, String description,
      Widget taskView, Color textColor, Color subHeaderColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => taskView));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textColor,
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
