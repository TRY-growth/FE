class NewsQuestion {
  final int newsSavePointId;
  final int newsId;
  final int gptGeneratedQuestionId;
  final String gptGeneratedQuestion;
  final String? userAnswer;
  final String? userAnswerFeedback;

  NewsQuestion({
    required this.newsSavePointId,
    required this.newsId,
    required this.gptGeneratedQuestionId,
    required this.gptGeneratedQuestion,
    this.userAnswer,
    this.userAnswerFeedback,
  });

  factory NewsQuestion.fromJson(Map<String, dynamic> json) {
    return NewsQuestion(
      newsSavePointId: json['newsSavePointId'],
      newsId: json['newsId'],
      gptGeneratedQuestionId: json['gptGeneratedQuestionId'],
      gptGeneratedQuestion: json['gptGeneratedQuestion'],
      userAnswer: json['userAnswer'],
      userAnswerFeedback: json['userAnswerFeedback'],
    );
  }
}
