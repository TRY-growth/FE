import 'package:flutter/material.dart';

class NewsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> newsData = [
      {
        "thumbnail": "https://via.placeholder.com/150",
        "title": "Sample News Title 1",
        "date": "2023-01-01",
        "content": "Detailed news content for news item 1."
      },
      {
        "thumbnail": "https://via.placeholder.com/150",
        "title": "Sample News Title 2",
        "date": "2023-01-02",
        "content": "Detailed news content for news item 2."
      },
      // Add more sample news data here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("News List"),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(newsData[index]['thumbnail']!),
            title: Text(newsData[index]['title']!),
            subtitle: Text(newsData[index]['date']!),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/news_detail', arguments: newsData[index]);
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tests'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
        ],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushNamed('/home');
          } else if (index == 1) {
            Navigator.of(context).pushNamed('/test');
          }
        },
      ),
    );
  }
}
