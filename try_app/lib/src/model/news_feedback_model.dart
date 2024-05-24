class NewsFeedback {
  final int newsSavePointId;
  final int newsId;
  final int gptGeneratedQuestionId;
  final String gptGeneratedQuestion;
  final String userAnswer;
  final String userAnswerFeedback;

  NewsFeedback({
    required this.newsSavePointId,
    required this.newsId,
    required this.gptGeneratedQuestionId,
    required this.gptGeneratedQuestion,
    required this.userAnswer,
    required this.userAnswerFeedback,
  });

  factory NewsFeedback.fromJson(Map<String, dynamic> json) {
    return NewsFeedback(
      newsSavePointId: json['newsSavePointId'],
      newsId: json['newsId'],
      gptGeneratedQuestionId: json['gptGeneratedQuestionId'],
      gptGeneratedQuestion: json['gptGeneratedQuestion'],
      userAnswer: json['userAnswer'],
      userAnswerFeedback: json['userAnswerFeedback'],
    );
  }
}
