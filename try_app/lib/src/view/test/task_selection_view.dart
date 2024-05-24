import 'package:flutter/material.dart';
import '../base_view.dart';

class TaskSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRY : TEST',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BaseView(
        currentIndex: 0,
        child: Padding(
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
                        '/task1',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTaskCard(
                        context,
                        'Task 2',
                        'Respond to a campus situation with your solutions.',
                        '/task2',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTaskCard(
                        context,
                        'Task 3',
                        'Discuss an academic topic from a lecture or reading.',
                        '/task3',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTaskCard(
                        context,
                        'Task 4',
                        'Synthesize information from multiple sources.',
                        '/task4',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, String title, String description, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  description,
                  style: TextStyle(
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
