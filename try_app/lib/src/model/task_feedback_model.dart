class Task1Feedback {
  final int feedbackId;
  final int userId;
  final int submitId;
  final String totalFeedback;
  final String detailFeedback;
  final String detailFeedback_modifiedAnswer;

  Task1Feedback({
    required this.feedbackId,
    required this.userId,
    required this.submitId,
    required this.totalFeedback,
    required this.detailFeedback,
    required this.detailFeedback_modifiedAnswer,
  });

  factory Task1Feedback.fromJson(Map<String, dynamic> json) {
    return Task1Feedback(
      feedbackId: json['feedbackId'],
      userId: json['userId'],
      submitId: json['submitId'],
      totalFeedback: json['totalFeedback'],
      detailFeedback: json['detailFeedback'],
      detailFeedback_modifiedAnswer: json['detailFeedback_modifiedAnswer'],
    );
  }
}
