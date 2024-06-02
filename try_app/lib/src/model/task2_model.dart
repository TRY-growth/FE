class Task2Model {
  final String taskId;
  final String passage;
  final String discussion;
  final String question;

  Task2Model({
    required this.taskId,
    required this.passage,
    required this.discussion,
    required this.question,
  });

  factory Task2Model.fromJson(Map<String, dynamic> json) {
    return Task2Model(
      taskId: json['taskId'],
      passage: json['passage'],
      discussion: json['discussion'],
      question: json['question'],
    );
  }
}
