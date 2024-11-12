import 'dart:async';

import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/domain/usecase/question/get_questions_usecase.dart';
import 'package:mobx/mobx.dart';
part 'single_question_store.g.dart';

class SingleQuestionStore = _SingleQuestionStore with _$SingleQuestionStore;

abstract class _SingleQuestionStore with Store {

  //Observable:-----------------------------------------------------------------
  @observable
  int _questionIndex = 0;

  @observable
  List<String> _userAnswers = [];

  @observable
  String currentQuizAnswer = '';


  //Action:---------------------------------------------------------------------
  @action
  void generateAnswerList(int length){
    _userAnswers = List.filled(length, "");
  }

  @action
  void changeQuestion(int index) {
    _questionIndex = index;
  }

  @action
  void setAnswer(int index, String userAnswer){
    _userAnswers[index] = userAnswer;
  }

  @action
  void setQuizAnswerValue(String value){
    currentQuizAnswer = value;
  }

  //Computed:-------------------------------------------------------------------
  @computed
  String get currentAnswer => _userAnswers[_questionIndex];


  @computed
  List<String> get userAnswers => _userAnswers;

  @computed
  int get currentIndex => _questionIndex;

}

