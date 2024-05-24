class News {
  final int newsId;
  final String newsTitle;
  final String newsCategory;
  final String newsReporter;
  final String newsDate;
  final String newsArticle;

  News({
    required this.newsId,
    required this.newsTitle,
    required this.newsCategory,
    required this.newsReporter,
    required this.newsDate,
    required this.newsArticle,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      newsId: json['newsId'],
      newsTitle: json['newsTitle'],
      newsCategory: json['newsCategory'],
      newsReporter: json['newsReporter'],
      newsDate: json['newsDate'],
      newsArticle: json['newsArticle'],
    );
  }
}
