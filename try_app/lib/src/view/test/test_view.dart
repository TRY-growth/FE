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
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              child: Row(
                children: const [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFF008F9C),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Select a Task',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF008F9C),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFF008F9C),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'assets/images/task1.png',
                      'Task 1',
                      'Express\nyour preference between 2 options.',
                      const Task1View(),
                      textColor,
                      subHeaderColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'assets/images/task2.png',
                      'Task 2',
                      'Respond to\na campus situation with your solutions.',
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
                      'assets/images/task3.png',
                      'Task 3',
                      'Discuss\nan academic topic\nfrom a reading.',
                      const Task3View(),
                      textColor,
                      subHeaderColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTaskCard(
                      context,
                      'assets/images/task4.png',
                      'Task 4',
                      'Synthesize\ninformation\nfrom a lecture.',
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

  Widget _buildTaskCard(
      BuildContext context,
      String iconPath,
      String title,
      String description,
      Widget taskView,
      Color textColor,
      Color subHeaderColor) {
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(iconPath, height: 77),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
