class Task1Feedback {
  final int task1FeedbackId;
  final int userId;
  final int task1SubmitId;
  final String task1TotalFeedback;
  final String task1DetailFeedback;
  final String task1DetailFeedbackModifiedAnswer;

  Task1Feedback({
    required this.task1FeedbackId,
    required this.userId,
    required this.task1SubmitId,
    required this.task1TotalFeedback,
    required this.task1DetailFeedback,
    required this.task1DetailFeedbackModifiedAnswer,
  });

  factory Task1Feedback.fromJson(Map<String, dynamic> json) {
    return Task1Feedback(
      task1FeedbackId: json['task1FeedbackId'],
      userId: json['userId'],
      task1SubmitId: json['task1SubmitId'],
      task1TotalFeedback: json['task1TotalFeedback'],
      task1DetailFeedback: json['task1DetailFeedback'],
      task1DetailFeedbackModifiedAnswer:
          json['task1DetailFeedback_modifiedAnswer'],
    );
  }
}
