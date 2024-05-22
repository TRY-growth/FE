import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('정보변경'),
            ),
            ElevatedButton(
              onPressed: () {
                // 로그아웃 로직
              },
              child: Text('로그아웃'),
            ),
            ElevatedButton(
              onPressed: () {
                // 회원탈퇴 로직
              },
              child: Text('회원탈퇴'),
            ),
          ],
        ),
      ),
    );
  }
}
