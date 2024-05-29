class Task3Question {
  final String taskId;
  final String passage;
  final String discussion;
  final String question;

  Task3Question({
    required this.taskId,
    required this.passage,
    required this.discussion,
    required this.question,
  });

  factory Task3Question.fromJson(Map<String, dynamic> json) {
    return Task3Question(
      taskId: json['taskId'],
      passage: json['passage'],
      discussion: json['discussion'],
      question: json['question'],
    );
  }
}
