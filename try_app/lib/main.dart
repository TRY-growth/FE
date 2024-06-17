import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'src/view/auth/login_view.dart';
import 'src/view/auth/login_view_model.dart';

import 'src/view/base_view.dart';

import 'src/repository/home_repository.dart';
import 'src/view/home/home_view_model.dart';

import 'src/view/test/test_view.dart';

import 'src/repository/task1_repository.dart';
import 'src/view/test/task1/task1_view_model.dart';

import 'src/repository/task2_repository.dart';
import 'src/view/test/task2/task2_view_model.dart';

import 'src/repository/task3_repository.dart';
import 'src/view/test/task3/task3_view_model.dart';

import 'src/repository/task4_repository.dart';
import 'src/view/test/task4/task4_view_model.dart';

import 'src/repository/news_repository.dart';
import 'src/view/news/news_view_model.dart';
import 'src/view/news/news_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(homeRepository: HomeRepository())),
        ChangeNotifierProvider(
            create: (_) => NewsViewModel(newsRepository: NewsRepository())),
        ChangeNotifierProvider(
            create: (_) => Task1ViewModel(task1Repository: Task1Repository())),
        ChangeNotifierProvider(
            create: (_) => Task2ViewModel(task2Repository: Task2Repository())),
        ChangeNotifierProvider(
            create: (_) => Task3ViewModel(task3Repository: Task3Repository())),
        ChangeNotifierProvider(
            create: (_) => Task4ViewModel(task4Repository: Task4Repository())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          fontFamily: 'Ridibatang',
        );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        textTheme: textTheme,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/home': (context) => const BaseView(),
        '/test': (context) => const TestView(),
        '/news': (context) => const NewsView(),
      },
    );
  }
}
