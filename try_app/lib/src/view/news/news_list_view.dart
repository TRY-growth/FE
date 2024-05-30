import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:try_app/src/view/news/news_view_model.dart';
import 'package:intl/intl.dart';

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  @override
  void initState() {
    super.initState();
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    newsViewModel.fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<NewsViewModel>(
        builder: (context, newsViewModel, child) {
          if (newsViewModel.newsList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: newsViewModel.newsList.length,
              itemBuilder: (context, index) {
                final news = newsViewModel.newsList[index];
                final date = DateTime.parse(news.newsDate);
                final formattedDate = DateFormat('MMM dd, yyyy').format(date);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 1 / 1, // 이미지의 비율을 1:1로 유지
                          child: Image.network(
                            news.newsURL,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Text(
                          news.newsTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(news.newsCategory),
                          Text(formattedDate),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/news_detail', arguments: news);
                      },
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
