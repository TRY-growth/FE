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
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
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
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildGuideCard(
                          iconPath: 'assets/images/timer.png',
                          title: 'Test',
                          description:
                              'Practice English\nthrough the\ntest environment',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildGuideCard(
                          iconPath: 'assets/images/news.png',
                          title: 'News',
                          description:
                              'Learn English\nthrough the\nlatest news',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    children: [
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
              ],
            ),
          ),
          Expanded(
            child: Consumer<HomeViewModel>(
              builder: (context, model, child) {
                if (model.learningHistory.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        Image.asset(
                          'assets/images/score.png',
                          // color: Colors.grey,
                          height: 150,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Your journey starts here.\nTry learning today!',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
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
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 0, bottom: 32),
                          child: _buildLearningCard(
                            context,
                            report.taskType,
                            DateFormat('MMM dd, yyyy')
                                .format(DateTime.parse(report.submitDate!)),
                            report,
                            textColor: textColor,
                            subHeaderColor: subHeaderColor,
                          ),
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
        height: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(iconPath, height: 55),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF210A3B),
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF210A3B),
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
        iconPath = 'assets/images/task1.png';
        break;
      case 'task2':
        iconPath = 'assets/images/task2.png';
        break;
      case 'task3':
        iconPath = 'assets/images/task3.png';
        break;
      case 'task4':
        iconPath = 'assets/images/task4.png';
        break;
      case 'news':
      default:
        iconPath = 'assets/images/news.png';
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 0),
      child: Rotation3d(
        rotationY: _normalizedOffset * _maxRotation,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          child: Container(
            width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconPath, height: 75),
                  const SizedBox(height: 15),
                  Text(
                    taskType,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    submitDate,
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                  const SizedBox(height: 20),
                  _buildScoreIcons(
                      int.tryParse(report.totalFeedback?.score ?? '0') ?? 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreIcons(int score) {
    List<Widget> icons = [];
    for (int i = 0; i < 4; i++) {
      icons.add(Image.asset(
        'assets/images/score.png',
        color: i < score ? null : Colors.grey.shade300,
        height: 40, // 점수 이미지 크기
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons,
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
