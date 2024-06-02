import 'dart:convert';

class ReportModel {
  final int reportId;
  final int? userId;
  final String taskId;
  final String taskType;
  final String? submitAnswer;
  final String? submitDate;
  final String? submitMemo;
  final String? submitRecording;
  final TotalFeedback? totalFeedback;
  final DetailFeedback? detailFeedback;
  final String? detailFeedbackModifiedAnswer;
  final String? newsQuestion;

  ReportModel({
    required this.reportId,
    this.userId,
    required this.taskId,
    required this.taskType,
    this.submitAnswer,
    this.submitDate,
    this.submitMemo,
    this.submitRecording,
    this.totalFeedback,
    this.detailFeedback,
    this.detailFeedbackModifiedAnswer,
    this.newsQuestion,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      reportId: json['reportId'],
      userId: json['userId'],
      taskId: json['taskId'],
      taskType: json['taskType'],
      submitAnswer: json['submitAnswer'],
      submitDate: json['submitDate'],
      submitMemo: json['submitMemo'],
      submitRecording: json['submitRecording'],
      totalFeedback: json['totalFeedback'] != null
          ? TotalFeedback.fromJson(jsonDecode(json['totalFeedback']))
          : null,
      detailFeedback: json['detailFeedback'] != null
          ? DetailFeedback.fromJson(jsonDecode(json['detailFeedback']))
          : null,
      detailFeedbackModifiedAnswer: json['detailFeedbackModifiedAnswer'],
      newsQuestion: json['newsQuestion'],
    );
  }
}

class TotalFeedback {
  final String score;
  final List<FeedbackDetail> feedback;
  final List<Tip> tip1;
  final List<Tip> tip2;
  final List<Tip> tip3;

  TotalFeedback({
    required this.score,
    required this.feedback,
    required this.tip1,
    required this.tip2,
    required this.tip3,
  });

  factory TotalFeedback.fromJson(Map<String, dynamic> json) {
    return TotalFeedback(
      score: json['score'],
      feedback: (json['feedback'] as List)
          .map((i) => FeedbackDetail.fromJson(i))
          .toList(),
      tip1: (json['tip1'] as List).map((i) => Tip.fromJson(i)).toList(),
      tip2: (json['tip2'] as List).map((i) => Tip.fromJson(i)).toList(),
      tip3: (json['tip3'] as List).map((i) => Tip.fromJson(i)).toList(),
    );
  }
}

class FeedbackDetail {
  final String overallFeedback;
  final String languageUseFeedback;
  final String topicDevelopmentFeedback;

  FeedbackDetail({
    required this.overallFeedback,
    required this.languageUseFeedback,
    required this.topicDevelopmentFeedback,
  });

  factory FeedbackDetail.fromJson(Map<String, dynamic> json) {
    return FeedbackDetail(
      overallFeedback: json['overall_feedback'],
      languageUseFeedback: json['language_use_feedback'],
      topicDevelopmentFeedback: json['topic_development_feedback'],
    );
  }
}

class Tip {
  final String subheading;
  final String feedback;

  Tip({
    required this.subheading,
    required this.feedback,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      subheading: json['subheading'],
      feedback: json['feedback'],
    );
  }
}

class DetailFeedback {
  final List<Correction> corrections;

  DetailFeedback({
    required this.corrections,
  });

  factory DetailFeedback.fromJson(Map<String, dynamic> json) {
    return DetailFeedback(
      corrections: (json['corrections'] as List)
          .map((i) => Correction.fromJson(i))
          .toList(),
    );
  }
}

class Correction {
  final int textOffset;
  final int textLength;
  final String originalText;
  final String correctedText;
  final String correctionReason;
  final String category;

  Correction({
    required this.textOffset,
    required this.textLength,
    required this.originalText,
    required this.correctedText,
    required this.correctionReason,
    required this.category,
  });

  factory Correction.fromJson(Map<String, dynamic> json) {
    return Correction(
      textOffset: json['text_offset'],
      textLength: json['text_length'],
      originalText: json['original_text'],
      correctedText: json['corrected_text'],
      correctionReason: json['correction_reason'],
      category: json['category'],
    );
  }
}
