import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:try_app/src/view/news/news_detail_view.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  NewsViewState createState() => NewsViewState();
}

class NewsViewState extends State<NewsView> {
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

    return RefreshIndicator(
      onRefresh: () async {
        final newsViewModel =
            Provider.of<NewsViewModel>(context, listen: false);
        newsViewModel.fetchAllNews();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 32, right: 32, bottom: 32),
        child: Consumer<NewsViewModel>(
          builder: (context, newsViewModel, child) {
            if (newsViewModel.newsList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: newsViewModel.newsList.length,
                itemBuilder: (context, index) {
                  final news = newsViewModel.newsList[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewsDetailView(news: news),
                          ),
                        );
                      },
                      child: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120,
                                height: 160,
                                child: Image.network(
                                  news.newsURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        news.newsCategory,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Barlow',
                                          color: subHeaderColor,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        news.newsTitle,
                                        style: const TextStyle(
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
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
