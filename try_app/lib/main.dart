import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/view/auth/login_view.dart';
import 'src/view/auth/signup_view.dart';
import 'src/view/base_view.dart';
import 'src/view/home/home_view_model.dart';
import 'src/view/test/common/feedback_view.dart';
import 'src/view/test/common/loading_view.dart';
import 'src/view/test/task_selection_view_model.dart';
import 'src/view/test/task_selection_view.dart';
import 'src/repository/task1_repository.dart';
import 'src/view/test/task1/task1_view_model.dart';
import 'src/view/test/task1/task1_view.dart';
import 'src/view/test/task2/task2_view.dart';
import 'src/view/test/task3/task3_view.dart';
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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final textTheme = GoogleFonts.notoSansKrTextTheme(
    //   Theme.of(context).textTheme,
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.teal,
        //   brightness: Brightness.light,
        // ),
        // textTheme: textTheme,
        useMaterial3: true,
        fontFamily: 'PretendardVariable',
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => LoginView(),
        '/signup': (context) => SignupView(),
        '/home': (context) => BaseView(),
        '/loading': (context) => LoadingView(),
        '/feedback': (context) => FeedbackView(),
        '/test': (context) => TaskSelectionView(),
        '/task1': (context) => Task1View(),
        '/news': (context) => NewsListView(),
        '/news_detail': (context) => NewsDetailView(),
        '/news_learning': (context) => NewsLearningView(),
        '/news_feedback': (context) => NewsFeedbackView(),
      },
    );
  }
}
