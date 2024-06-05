import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:try_app/src/model/report_model.dart';
import 'home_view_model.dart';
import 'learning_history_view.dart';
import 'rotation_3d.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final double _maxRotation = 20;
  PageController? _pageController;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;
  late AnimationController _tweenController;
  final Tween<double> _tween = Tween<double>(begin: -1, end: 0);
  late Animation<double> _tweenAnim;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _tweenController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _tweenAnim = _tween.animate(
      CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut),
    )..addListener(() => _setOffset(_tweenAnim.value));
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _tweenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fetchLearningHistory();

    const textColor = Color(0xFF210A3B);
    const subHeaderColor = Color(0xFF008F9C);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                // const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
                const EdgeInsets.only(left: 22, right: 22, top: 24, bottom: 8),
            child: _buildGuideCard(
              iconPath: 'assets/images/timer.png',
              title: 'Timed Test',
              description:
                  'Practice your English skills in a timed test environment.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
            child: _buildGuideCard(
              iconPath: 'assets/images/news.png',
              title: 'News Practice',
              description: 'Learn English expressions through the latest news.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
                  'Learning History',
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
            child: Consumer<HomeViewModel>(
              builder: (context, model, child) {
                if (model.learningHistory.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Listener(
                  onPointerUp: _handlePointerUp,
                  child: NotificationListener(
                    onNotification: _handleScrollNotifications,
                    child: PageView.builder(
                      controller: _pageController,
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard({
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 50),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF210A3B),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF210A3B),
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

  Widget _buildLearningCard(
    BuildContext context,
    String taskType,
    String submitDate,
    ReportModel report, {
    required Color textColor,
    required Color subHeaderColor,
  }) {
    String iconPath;
    switch (taskType) {
      case 'task1':
        iconPath = 'assets/images/task1.png'; // Replace with actual path
        break;
      case 'task2':
        iconPath = 'assets/images/task2.png'; // Replace with actual path
        break;
      case 'task3':
        iconPath = 'assets/images/task3.png'; // Replace with actual path
        break;
      case 'task4':
        iconPath = 'assets/images/task4.png'; // Replace with actual path
        break;
      case 'news':
      default:
        iconPath = 'assets/images/news.png'; // Replace with actual path
        break;
    }

    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 32),
      child: Rotation3d(
        rotationY: _normalizedOffset * _maxRotation,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          child: Container(
            height: 220,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // boxShadow: const [
              //   BoxShadow(color: Colors.black12, blurRadius: 4),
              //   BoxShadow(color: Colors.black12, blurRadius: 10),
              // ],
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconPath, height: 80),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Text(
                    'Score: ${report.totalFeedback?.score ?? 'N/A'} / 4',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: subHeaderColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      _tweenController.stop();
    }
    return true;
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) {
    setState(() {
      _normalizedOffset = value;
    });
  }

  void _startOffsetTweenToZero() {
    _tween.begin = _normalizedOffset;
    _tweenController.reset();
    _tween.end = 0;
    _tweenController.forward();
  }
}
