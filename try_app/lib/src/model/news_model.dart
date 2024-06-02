class NewsModel {
  final int newsId;
  final String newsTitle;
  final String newsCategory;
  final String newsReporter;
  final String newsDate;
  final String newsURL;
  final String newsArticle;

  NewsModel({
    required this.newsId,
    required this.newsTitle,
    required this.newsCategory,
    required this.newsReporter,
    required this.newsDate,
    required this.newsURL,
    required this.newsArticle,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      newsId: json['newsId'],
      newsTitle: json['newsTitle'],
      newsCategory: json['newsCategory'],
      newsReporter: json['newsReporter'],
      newsDate: json['newsDate'],
      newsURL: json['newsURL'],
      newsArticle: json['newsArticle'],
    );
  }
}
