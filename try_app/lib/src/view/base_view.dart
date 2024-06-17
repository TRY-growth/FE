import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:try_app/src/view/home/home_view.dart';
import 'package:try_app/src/view/test/test_view.dart';
import 'package:try_app/src/view/news/news_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  BaseViewState createState() => BaseViewState();
}

class BaseViewState extends State<BaseView> {
  int _currentIndex = 1;

  final List<Widget> _children = [
    const TestView(),
    const HomeView(),
    const NewsView(),
  ];

  void _handleNavigationChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF210A3B);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              _getAppBarTitle(_currentIndex),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: 'Merriweather',
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _showProfileDialog(context),
              child: const Icon(Icons.account_circle, color: textColor),
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
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(icon: Icons.timer),
          FluidNavBarIcon(icon: Icons.energy_savings_leaf),
          FluidNavBarIcon(icon: Icons.newspaper),
        ],
        onChange: _handleNavigationChange,
        scaleFactor: 1.5,
        defaultIndex: 1,
        style: const FluidNavBarStyle(
          iconSelectedForegroundColor: Color(0xFF008F9C),
        ),
      ),
    );
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
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('정보수정'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showEditProfileDialog(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('로그아웃'),
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
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Email: user@example.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Save',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // 회원탈퇴
                        Navigator.of(context).pop();
                      },
                      child: const Text(
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
}
