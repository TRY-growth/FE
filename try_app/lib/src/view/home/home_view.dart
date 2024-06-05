import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:try_app/src/model/report_model.dart';
import 'home_view_model.dart';
import 'learning_history_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchLearningHistory();

    const textColor = Color(0xFF210A3B);
    const subHeaderColor = Color(0xFF008F9C);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildNavigationCard(
                    context,
                    title: 'Test',
                    description:
                        'Practice your English skills with various types of tests.',
                    route: '/test',
                    icon: Icons.school,
                    textColor: textColor,
                    subHeaderColor: subHeaderColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildNavigationCard(
                    context,
                    title: 'News',
                    description:
                        'Read the latest news and learn English expressions.',
                    route: '/news',
                    icon: Icons.article,
                    textColor: textColor,
                    subHeaderColor: subHeaderColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Learning History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                        DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(report.submitDate!)),
                        report,
                        textColor: textColor,
                        subHeaderColor: subHeaderColor,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String description,
    required String route,
    required IconData icon,
    required Color textColor,
    required Color subHeaderColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(24),
            height: 300, // 높이를 동일하게 설정
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: subHeaderColor),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: textColor),
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
    ReportModel report, {
    required Color textColor,
    required Color subHeaderColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  submitDate,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
