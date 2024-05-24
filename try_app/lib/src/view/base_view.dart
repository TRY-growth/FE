import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  BaseView({required this.child, this.currentIndex = 1}); // 기본값을 홈 화면으로 설정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/test');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/news');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Test'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
        ],
      ),
    );
  }
}
