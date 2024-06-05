import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:try_app/src/view/news/news_detail_view.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    newsViewModel.fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF210A3B);
    const subHeaderColor = Color(0xFF008F9C);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<NewsViewModel>(
        builder: (context, newsViewModel, child) {
          if (newsViewModel.newsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: newsViewModel.newsList.length,
              itemBuilder: (context, index) {
                final news = newsViewModel.newsList[index];
                final date = DateTime.parse(news.newsDate);
                final formattedDate = DateFormat('MMM dd, yyyy').format(date);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewsDetailView(news: news),
                        ),
                      );
                    },
                    child: Container(
                      height: 150, // 고정 높이 설정
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 150,
                                child: Image.network(
                                  news.newsURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 120,
                                height: 150,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    news.newsCategory,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Barlow',
                                      color: subHeaderColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    news.newsTitle,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Merriweather',
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
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
        },
      ),
    );
  }
}
