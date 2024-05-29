import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/view/auth/login_view.dart';
import 'src/view/auth/signup_view.dart';

import 'src/view/base_view.dart';

import 'src/view/home/home_view_model.dart';

import 'src/view/test/common/loading_view.dart';
import 'src/view/test/common/feedback_view.dart';

import 'src/view/test/task_selection_view_model.dart';
import 'src/view/test/task_selection_view.dart';

import 'src/repository/task1_repository.dart';
import 'src/view/test/task1/task1_view_model.dart';
import 'src/view/test/task1/task1_view.dart';

import 'src/repository/task2_repository.dart';
import 'src/view/test/task2/task2_view_model.dart';
import 'src/view/test/task2/task2_view.dart';

import 'src/repository/task3_repository.dart';
import 'src/view/test/task3/task3_view_model.dart';
import 'src/view/test/task3/task3_view.dart';

import 'src/repository/task4_repository.dart';
import 'src/view/test/task4/task4_view_model.dart';
import 'src/view/test/task4/task4_view.dart';

import 'src/repository/news_repository.dart';
import 'src/view/news/news_view_model.dart';
import 'src/view/news/news_list_view.dart';
import 'src/view/news/news_detail_view.dart';
import 'src/view/news/news_learning_view.dart';
import 'src/view/news/news_feedback_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => TaskSelectionViewModel()),
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.notoSansKrTextTheme(
      Theme.of(context).textTheme,
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
        '/': (context) => LoginView(),
        '/signup': (context) => SignupView(),
        '/home': (context) => BaseView(),
        '/loading': (context) => LoadingView(),
        '/feedback': (context) => FeedbackView(),
        '/test': (context) => TaskSelectionView(),
        '/task1': (context) => Task1View(),
        '/task2': (context) => Task2View(),
        '/task3': (context) => Task3View(),
        '/task4': (context) => Task4View(),
        '/news': (context) => NewsListView(),
        '/news_detail': (context) => NewsDetailView(),
        '/news_learning': (context) => NewsLearningView(),
        '/news_feedback': (context) => NewsFeedbackView(),
      },
    );
  }
}
