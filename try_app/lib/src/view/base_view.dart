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

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('정보수정'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showEditProfileDialog(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('로그아웃'),
                    onTap: () {
                      // 로그아웃 로직 추가
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Email: user@example.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // 회원탈퇴 로직 추가
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Save',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // 회원탈퇴 로직 추가
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '회원탈퇴',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
              onTap: () => _showProfileDialog(context),
              child: Icon(Icons.account_circle),
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
