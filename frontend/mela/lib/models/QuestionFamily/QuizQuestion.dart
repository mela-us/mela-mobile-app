import 'dart:collection';

import 'package:mela/models/QuestionFamily/AQuestion.dart';

class QuizQuestion extends AQuestion{
  QuizQuestion({
    required this.quizChoice,
    required super.id,
    required super.questionContent,
    required super.answer,
    required super.imageUrl
  });

  final List<String> quizChoice; //Follow the rule, a,b,c,d.
  Map<String, String> choiceMap = Map();
  @override
  bool isCorrect(String userAnswer) {
    if (userAnswer == this.answer){
      return true;
    }
    return false;
  }

  void buildMap(){
    for (String choice in quizChoice){
      this.choiceMap.addAll({
        String.fromCharCode(quizChoice.indexOf(choice) + 65): choice
      });
    }
  }
}