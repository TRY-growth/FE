class Task3Model {
  final String taskId;
  final String passage;
  final String discussion;
  final String question;

  Task3Model({
    required this.taskId,
    required this.passage,
    required this.discussion,
    required this.question,
  });

  factory Task3Model.fromJson(Map<String, dynamic> json) {
    return Task3Model(
      taskId: json['taskId'],
      passage: json['passage'],
      discussion: json['discussion'],
      question: json['question'],
    );
  }
}
