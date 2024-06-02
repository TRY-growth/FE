class Task4Model {
  final String taskId;
  final String lecture;
  final String question;

  Task4Model({
    required this.taskId,
    required this.lecture,
    required this.question,
  });

  factory Task4Model.fromJson(Map<String, dynamic> json) {
    return Task4Model(
      taskId: json['taskId'],
      lecture: json['lecture'],
      question: json['question'],
    );
  }
}
