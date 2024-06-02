import 'package:flutter/material.dart';

import 'package:try_app/src/view/test/task1/task1_view.dart';
import 'package:try_app/src/view/test/task2/task2_view.dart';
import 'package:try_app/src/view/test/task3/task3_view.dart';
import 'package:try_app/src/view/test/task4/task4_view.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTaskCard(
                    context,
                    'Task 2',
                    'Respond to a campus situation with your solutions.',
                    const Task2View(),
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
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTaskCard(
                    context,
                    'Task 4',
                    'Synthesize information from multiple sources.',
                    const Task4View(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, String title, String description, Widget taskView) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => taskView));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
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
