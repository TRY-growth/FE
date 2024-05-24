import 'package:flutter/material.dart';
import 'package:try_app/src/view/home/home_view.dart';
import 'package:try_app/src/view/test/task_selection_view.dart';
import 'package:try_app/src/view/news/news_list_view.dart';

class BaseView extends StatefulWidget {
  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    TaskSelectionView(),
    HomeView(),
    NewsListView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'TRY : TEST';
      case 1:
        return 'TRY';
      case 2:
        return 'TRY : NEWS';
      default:
        return 'TRY APP';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              _getAppBarTitle(_currentIndex),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user');
              },
              child: Icon(Icons.account_circle, color: Colors.teal, size: 33),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Test'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
        ],
      ),
    );
  }
}
