class Task1Question {
  final String task1Id;
  final String task1Question;
  final String task1ModelAnswer;

  Task1Question({
    required this.task1Id,
    required this.task1Question,
    required this.task1ModelAnswer,
  });

  factory Task1Question.fromJson(Map<String, dynamic> json) {
    return Task1Question(
      task1Id: json['task1Id'],
      task1Question: json['task1Question'],
      task1ModelAnswer: json['task1ModelAnswer'],
    );
  }
}
