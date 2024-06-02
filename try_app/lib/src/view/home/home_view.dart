import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/model/report_model.dart';
import 'home_view_model.dart';
import 'learning_history_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchLearningHistory();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavigationCard(
                  context,
                  title: 'Practice Test',
                  description:
                      'Master the speaking section by practicing structured tasks.',
                  route: '/test',
                  icon: Icons.school,
                ),
                const SizedBox(height: 10),
                _buildNavigationCard(
                  context,
                  title: 'Study with News',
                  description:
                      'Enhance your listening and speaking skills with real-world news.',
                  route: '/news',
                  icon: Icons.article,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Learning History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Consumer<HomeViewModel>(
              builder: (context, model, child) {
                if (model.learningHistory.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.learningHistory.length,
                  itemBuilder: (context, index) {
                    final report = model.learningHistory[index];
                    return _buildLearningCard(
                      context,
                      report.taskType,
                      report.submitDate!,
                      report,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String description,
    required String route,
    required IconData icon,
  }) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearningCard(
    BuildContext context,
    String taskType,
    String submitDate,
    ReportModel report,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LearningHistoryView(report: report),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskType,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(submitDate),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
