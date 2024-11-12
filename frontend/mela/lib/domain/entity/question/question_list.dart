import 'package:mela/domain/entity/question/fill_question.dart';
import 'package:mela/domain/entity/question/quiz_question.dart';

import 'question.dart';

class QuestionList{
  final List<Question>? questions;

  QuestionList({
    this.questions,
  });

  factory QuestionList.fromJson(List<dynamic> json) {
    List<Question> questions = <Question>[];
    questions = json.map((question) => Question.fromMap(question)).toList();

    return QuestionList(
      questions: questions,
    );
  }
}