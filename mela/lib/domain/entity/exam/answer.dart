import 'dart:io';

import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/question/question.dart';

class ExamAnswerModel {
  String questionId;
  String? blankAnswer;
  String? quizAnswer;
  String? subjectiveTextPart;
  List<File>? subjectiveImagePart;
  QuestionType type;

  ExamAnswerModel({
    required this.type,
    required this.questionId,
    this.blankAnswer,
    this.quizAnswer,
    this.subjectiveTextPart,
    this.subjectiveImagePart,
  });
}
