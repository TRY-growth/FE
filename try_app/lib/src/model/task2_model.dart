class Task2Question {
  final String taskId;
  final String passage;
  final String discussion;
  final String question;
  // final String modelAnswer;

  Task2Question({
    required this.taskId,
    required this.passage,
    required this.discussion,
    required this.question,
    // required this.modelAnswer,
  });

  factory Task2Question.fromJson(Map<String, dynamic> json) {
    return Task2Question(
      taskId: json['taskId'],
      passage: json['passage'],
      discussion: json['discussion'],
      question: json['question'],
      // modelAnswer: json['modelAnswer'],
    );
  }
}
