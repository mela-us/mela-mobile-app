// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrentQuestionStore on _CurrentQuestionStore, Store {
  late final _$currentQuestionIndexAtom = Atom(
      name: '_CurrentQuestionStore.currentQuestionIndex', context: context);

  @override
  int get currentQuestionIndex {
    _$currentQuestionIndexAtom.reportRead();
    return super.currentQuestionIndex;
  }

  @override
  set currentQuestionIndex(int value) {
    _$currentQuestionIndexAtom.reportWrite(value, super.currentQuestionIndex,
        () {
      super.currentQuestionIndex = value;
    });
  }

  late final _$currentQuestionAtom =
      Atom(name: '_CurrentQuestionStore.currentQuestion', context: context);

  @override
  String get currentQuestion {
    _$currentQuestionAtom.reportRead();
    return super.currentQuestion;
  }

  @override
  set currentQuestion(String value) {
    _$currentQuestionAtom.reportWrite(value, super.currentQuestion, () {
      super.currentQuestion = value;
    });
  }

  late final _$currentAnswerAtom =
      Atom(name: '_CurrentQuestionStore.currentAnswer', context: context);

  @override
  String get currentAnswer {
    _$currentAnswerAtom.reportRead();
    return super.currentAnswer;
  }

  @override
  set currentAnswer(String value) {
    _$currentAnswerAtom.reportWrite(value, super.currentAnswer, () {
      super.currentAnswer = value;
    });
  }

  late final _$_CurrentQuestionStoreActionController =
      ActionController(name: '_CurrentQuestionStore', context: context);

  @override
  void setCurrentQuestionIndex(int index) {
    final _$actionInfo = _$_CurrentQuestionStoreActionController.startAction(
        name: '_CurrentQuestionStore.setCurrentQuestionIndex');
    try {
      return super.setCurrentQuestionIndex(index);
    } finally {
      _$_CurrentQuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentQuestion(String question) {
    final _$actionInfo = _$_CurrentQuestionStoreActionController.startAction(
        name: '_CurrentQuestionStore.setCurrentQuestion');
    try {
      return super.setCurrentQuestion(question);
    } finally {
      _$_CurrentQuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentAnswer(String answer) {
    final _$actionInfo = _$_CurrentQuestionStoreActionController.startAction(
        name: '_CurrentQuestionStore.setCurrentAnswer');
    try {
      return super.setCurrentAnswer(answer);
    } finally {
      _$_CurrentQuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetCurrentQuestion() {
    final _$actionInfo = _$_CurrentQuestionStoreActionController.startAction(
        name: '_CurrentQuestionStore.resetCurrentQuestion');
    try {
      return super.resetCurrentQuestion();
    } finally {
      _$_CurrentQuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentQuestionIndex: ${currentQuestionIndex},
currentQuestion: ${currentQuestion},
currentAnswer: ${currentAnswer}
    ''';
  }
}
