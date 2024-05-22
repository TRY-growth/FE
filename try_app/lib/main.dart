import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/view/auth/login_view.dart';
import 'src/view/auth/signup_view.dart';
import 'src/view/home/home_view.dart';
import 'src/view/news/news_list_view.dart';
import 'src/view/test/task_selection_view.dart';
import 'src/view/profile/profile_view.dart';
import 'src/view/profile/user_view.dart';
import 'src/view/home/home_view_model.dart';
import 'src/view/profile/user_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        // 추가 Providers 필요시 여기에 추가
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Try App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/signup': (context) => SignupView(),
        '/home': (context) => HomeView(),
        // '/news': (context) => NewsListView(),
        // '/test': (context) => TaskSelectionView(),
        '/user': (context) => UserView(),
        '/profile': (context) => ProfileView(),
      },
    );
  }
}
