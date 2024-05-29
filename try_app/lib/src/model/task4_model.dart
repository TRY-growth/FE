class Task4Question {
  final String taskId;
  final String lecture;
  final String question;

  Task4Question({
    required this.taskId,
    required this.lecture,
    required this.question,
  });

  factory Task4Question.fromJson(Map<String, dynamic> json) {
    return Task4Question(
      taskId: json['taskId'],
      lecture: json['lecture'],
      question: json['question'],
    );
  }
}
