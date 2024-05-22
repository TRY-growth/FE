import 'package:flutter/material.dart';
import '../base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      currentIndex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user');
              },
              child: Text('Welcome, User!'), // 사용자 이름 부분
            ),
            // 학습 이력 표시 (예시)
            Text('Learning History:'),
            // 실제 학습 이력 데이터로 대체 필요
          ],
        ),
      ),
    );
  }
}
