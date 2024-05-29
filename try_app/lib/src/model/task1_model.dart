class Task1Question {
  final String taskId;
  final String question;
  // final String modelAnswer;

  Task1Question({
    required this.taskId,
    required this.question,
    // required this.modelAnswer,
  });

  factory Task1Question.fromJson(Map<String, dynamic> json) {
    return Task1Question(
      taskId: json['taskId'],
      question: json['question'],
      // modelAnswer: json['modelAnswer'],
    );
  }
}
