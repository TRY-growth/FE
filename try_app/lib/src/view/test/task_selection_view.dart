import 'package:flutter/material.dart';
import '../base_view.dart';

class TaskSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      currentIndex: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/task1');
              },
              child: Text('Task 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/task2');
              },
              child: Text('Task 2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/task3');
              },
              child: Text('Task 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/task4');
              },
              child: Text('Task 4'),
            ),
          ],
        ),
      ),
    );
  }
}
