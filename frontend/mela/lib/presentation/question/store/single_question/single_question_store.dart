import 'dart:io';

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
  List<List<File>> userImage = [];

  @observable
  String currentQuizAnswer = '';

  @observable
  List<String> currentImageAnswer = [];

  //Action:---------------------------------------------------------------------
  @action
  void generateAnswerList(int length) {
    _userAnswers = List.filled(length, "");
    userImage = List.generate(length, (_) => []);
  }

  @action
  void changeQuestion(int index) {
    _questionIndex = index;
  }

  @action
  void setAnswer(int index, String userAnswer) {
    _userAnswers[index] = userAnswer;
  }

  @action
  void setQuizAnswerValue(String value) {
    currentQuizAnswer = value;
  }

  @action
  void setImageAnswer(int index, List<File> images) {
    if (userImage.length > index) {
      print(
          'Updating existing image list at index $index, images size is ${images.length}');
      for (var image in images) {
        if (!userImage[index].contains(image)) {
          print('Adding new image to existing list with path ${image.path}');
        }
      }
      userImage[index].clear();
      userImage[index].addAll(images);
    } else {
      print('Adding new image list at index $index');
      userImage.add(images);
    }
  }

  void printAllAnswer() {
    for (String answer in _userAnswers) {
      print('$answer');
    }
  }

  //Computed:-------------------------------------------------------------------
  @computed
  String get currentAnswer => _userAnswers[_questionIndex];

  @computed
  List<String> get userAnswers => _userAnswers;

  @computed
  int get currentIndex => _questionIndex;
}
