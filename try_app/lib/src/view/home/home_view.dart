import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, User!'),
            // 학습 이력 표시 (예시)
            Text('Learning History:'),
            // 실제 학습 이력 데이터로 대체 필요
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Test'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Home 화면으로 이동
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              // News 목록 화면으로 이동
              Navigator.pushNamed(context, '/news');
              break;
            case 2:
              // Test 선택 화면으로 이동
              Navigator.pushNamed(context, '/test_selection');
              break;
          }
        },
      ),
    );
  }
}
