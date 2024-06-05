import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:try_app/src/model/news_model.dart';
import 'package:try_app/src/view/news/drop_cap_text.dart';
import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:try_app/src/view/test/common/loading_view.dart';
import 'package:try_app/src/view/news/news_learning_view.dart';

class NewsDetailView extends StatelessWidget {
  final NewsModel news;

  const NewsDetailView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

    void startLearning() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoadingView(
          future: newsViewModel.fetchNewsQuestion(news.newsId),
          nextWidget: (context, report) => NewsLearningView(report: report),
        ),
      ));
    }

    const textColor = Color(0xFF210A3B);
    const subHeaderColor = Color(0xFF008F9C);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFFFFFFF),
          padding:
              const EdgeInsets.only(left: 37, right: 37, top: 30, bottom: 37),
          // padding: EdgeInsets.all(37),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.newsTitle,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Merriweather',
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: textColor,
                  decoration: TextDecoration.none,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 24)),
              Text(
                DateFormat('MMM dd, yyyy')
                    .format(DateTime.parse(news.newsDate)),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Merriweather',
                  color: subHeaderColor,
                  decoration: TextDecoration.none,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              Container(
                height: 1,
                color: const Color(0x512B777E),
              ),
              const Padding(padding: EdgeInsets.only(top: 24)),
              Image.network(news.newsURL, fit: BoxFit.cover),
              const Padding(padding: EdgeInsets.only(top: 24)),
              DropCapText(
                news.newsArticle,
                mode: DropCapMode.baseline,
                dropCapStyle: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Merriweather',
                  color: subHeaderColor,
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Barlow',
                  letterSpacing: 0.5,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  decoration: TextDecoration.none,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 32)),
              Center(
                child: SizedBox(
                  width: double.infinity, // 버튼 폭을 본문 폭과 동일하게 설정
                  child: ElevatedButton(
                    onPressed: startLearning,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: subHeaderColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Start Learning",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
