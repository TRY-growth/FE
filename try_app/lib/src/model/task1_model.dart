class Task1Model {
  final String taskId;
  final String question;

  Task1Model({
    required this.taskId,
    required this.question,
  });

  factory Task1Model.fromJson(Map<String, dynamic> json) {
    return Task1Model(
      taskId: json['taskId'],
      question: json['question'],
    );
  }
}
