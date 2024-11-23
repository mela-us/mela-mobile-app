// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuestionStore on _QuestionStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_QuestionStore.loading'))
      .value;

  late final _$fetchQuestionsFutureAtom =
      Atom(name: '_QuestionStore.fetchQuestionsFuture', context: context);

  @override
  ObservableFuture<QuestionList?> get fetchQuestionsFuture {
    _$fetchQuestionsFutureAtom.reportRead();
    return super.fetchQuestionsFuture;
  }

  @override
  set fetchQuestionsFuture(ObservableFuture<QuestionList?> value) {
    _$fetchQuestionsFutureAtom.reportWrite(value, super.fetchQuestionsFuture,
        () {
      super.fetchQuestionsFuture = value;
    });
  }

  late final _$questionListAtom =
      Atom(name: '_QuestionStore.questionList', context: context);

  @override
  QuestionList? get questionList {
    _$questionListAtom.reportRead();
    return super.questionList;
  }

  @override
  set questionList(QuestionList? value) {
    _$questionListAtom.reportWrite(value, super.questionList, () {
      super.questionList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_QuestionStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$isQuitAtom =
      Atom(name: '_QuestionStore.isQuit', context: context);

  @override
  QuitOverlayResponse get isQuit {
    _$isQuitAtom.reportRead();
    return super.isQuit;
  }

  @override
  set isQuit(QuitOverlayResponse value) {
    _$isQuitAtom.reportWrite(value, super.isQuit, () {
      super.isQuit = value;
    });
  }

  late final _$getQuestionsAsyncAction =
      AsyncAction('_QuestionStore.getQuestions', context: context);

  @override
  Future<dynamic> getQuestions() {
    return _$getQuestionsAsyncAction.run(() => super.getQuestions());
  }

  late final _$_QuestionStoreActionController =
      ActionController(name: '_QuestionStore', context: context);

  @override
  void setQuit(QuitOverlayResponse value) {
    final _$actionInfo = _$_QuestionStoreActionController.startAction(
        name: '_QuestionStore.setQuit');
    try {
      return super.setQuit(value);
    } finally {
      _$_QuestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchQuestionsFuture: ${fetchQuestionsFuture},
questionList: ${questionList},
success: ${success},
isQuit: ${isQuit},
loading: ${loading}
    ''';
  }
}
