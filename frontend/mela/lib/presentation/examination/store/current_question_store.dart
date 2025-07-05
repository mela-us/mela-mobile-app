import 'package:mobx/mobx.dart';

part 'current_question_store.g.dart';

class CurrentQuestionStore = _CurrentQuestionStore with _$CurrentQuestionStore;

abstract class _CurrentQuestionStore with Store {
  // Observable properties
  @observable
  int currentQuestionIndex = 0;

  @observable
  String currentQuestion = '';

  @observable
  String currentAnswer = '';

  // Actions to modify the state
  @action
  void setCurrentQuestionIndex(int index) {
    currentQuestionIndex = index;
  }

  @action
  void setCurrentQuestion(String question) {
    currentQuestion = question;
  }

  @action
  void setCurrentAnswer(String answer) {
    currentAnswer = answer;
  }

  //Reset the current question state
  @action
  void resetCurrentQuestion() {
    currentQuestionIndex = 0;
    currentQuestion = '';
    currentAnswer = '';
  }
}
