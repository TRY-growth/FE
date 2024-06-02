class Task1Question {
  final String taskId;
  final String question;

  Task1Question({
    required this.taskId,
    required this.question,
  });

  factory Task1Question.fromJson(Map<String, dynamic> json) {
    return Task1Question(
      taskId: json['taskId'],
      question: json['question'],
    );
  }
}
