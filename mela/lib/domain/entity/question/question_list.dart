import 'question.dart';

class QuestionList{
  final String message;
  final int size;
  final List<Question>? questions;

  QuestionList({
    required this.message,
    required this.size,
    required this.questions
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) {
    return QuestionList(
      message: json['message'],
      size: json['total'],
      questions: (json['questions'] as List<dynamic>).map(
              (q) => Question.fromJson(q)).toList(),
    );
  }
}