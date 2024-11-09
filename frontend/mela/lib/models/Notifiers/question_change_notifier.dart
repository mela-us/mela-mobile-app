import 'package:flutter/cupertino.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/models/QuestionFamily/FitbQuestion.dart';

class QAMixNotifier extends ChangeNotifier{
  AQuestion _question = FitbQuestion(id: 'id', questionContent: '', answer: 'answer', imageUrl: []);
  int _index = 2;
  String _answer = '';


  AQuestion get question => _question;
  int get index => _index;
  String get answer => _answer;

  void updateQAMix(AQuestion newQuestion, int newIndex, String newAnswer){
    _question = newQuestion;
    _index = newIndex;
    _answer = newAnswer;
    notifyListeners();
  }
}