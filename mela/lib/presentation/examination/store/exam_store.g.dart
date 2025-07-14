// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExamStore on _ExamStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ExamStore.loading'))
      .value;
  Computed<bool>? _$savingComputed;

  @override
  bool get saving => (_$savingComputed ??=
          Computed<bool>(() => super.saving, name: '_ExamStore.saving'))
      .value;

  late final _$fetchQuestionsFutureAtom =
      Atom(name: '_ExamStore.fetchQuestionsFuture', context: context);

  @override
  ObservableFuture<ExamModel?> get fetchQuestionsFuture {
    _$fetchQuestionsFutureAtom.reportRead();
    return super.fetchQuestionsFuture;
  }

  @override
  set fetchQuestionsFuture(ObservableFuture<ExamModel?> value) {
    _$fetchQuestionsFutureAtom.reportWrite(value, super.fetchQuestionsFuture,
        () {
      super.fetchQuestionsFuture = value;
    });
  }

  late final _$saveUserResultAtom =
      Atom(name: '_ExamStore.saveUserResult', context: context);

  @override
  ObservableFuture<int?> get saveUserResult {
    _$saveUserResultAtom.reportRead();
    return super.saveUserResult;
  }

  @override
  set saveUserResult(ObservableFuture<int?> value) {
    _$saveUserResultAtom.reportWrite(value, super.saveUserResult, () {
      super.saveUserResult = value;
    });
  }

  late final _$fetchExerciseAnswerFutureAtom =
      Atom(name: '_ExamStore.fetchExerciseAnswerFuture', context: context);

  @override
  ObservableFuture<ExerciseResult> get fetchExerciseAnswerFuture {
    _$fetchExerciseAnswerFutureAtom.reportRead();
    return super.fetchExerciseAnswerFuture;
  }

  @override
  set fetchExerciseAnswerFuture(ObservableFuture<ExerciseResult> value) {
    _$fetchExerciseAnswerFutureAtom
        .reportWrite(value, super.fetchExerciseAnswerFuture, () {
      super.fetchExerciseAnswerFuture = value;
    });
  }

  late final _$uploadImagesFutureAtom =
      Atom(name: '_ExamStore.uploadImagesFuture', context: context);

  @override
  ObservableFuture<List<List<String>?>> get uploadImagesFuture {
    _$uploadImagesFutureAtom.reportRead();
    return super.uploadImagesFuture;
  }

  @override
  set uploadImagesFuture(ObservableFuture<List<List<String>?>> value) {
    _$uploadImagesFutureAtom.reportWrite(value, super.uploadImagesFuture, () {
      super.uploadImagesFuture = value;
    });
  }

  late final _$examAtom = Atom(name: '_ExamStore.exam', context: context);

  @override
  ExamModel? get exam {
    _$examAtom.reportRead();
    return super.exam;
  }

  @override
  set exam(ExamModel? value) {
    _$examAtom.reportWrite(value, super.exam, () {
      super.exam = value;
    });
  }

  late final _$exerciseResultAtom =
      Atom(name: '_ExamStore.exerciseResult', context: context);

  @override
  ExerciseResult? get exerciseResult {
    _$exerciseResultAtom.reportRead();
    return super.exerciseResult;
  }

  @override
  set exerciseResult(ExerciseResult? value) {
    _$exerciseResultAtom.reportWrite(value, super.exerciseResult, () {
      super.exerciseResult = value;
    });
  }

  late final _$isUploadingImagesAtom =
      Atom(name: '_ExamStore.isUploadingImages', context: context);

  @override
  bool get isUploadingImages {
    _$isUploadingImagesAtom.reportRead();
    return super.isUploadingImages;
  }

  @override
  set isUploadingImages(bool value) {
    _$isUploadingImagesAtom.reportWrite(value, super.isUploadingImages, () {
      super.isUploadingImages = value;
    });
  }

  late final _$successAtom = Atom(name: '_ExamStore.success', context: context);

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

  late final _$isAuthorizedAtom =
      Atom(name: '_ExamStore.isAuthorized', context: context);

  @override
  bool get isAuthorized {
    _$isAuthorizedAtom.reportRead();
    return super.isAuthorized;
  }

  @override
  set isAuthorized(bool value) {
    _$isAuthorizedAtom.reportWrite(value, super.isAuthorized, () {
      super.isAuthorized = value;
    });
  }

  late final _$questionsUidAtom =
      Atom(name: '_ExamStore.questionsUid', context: context);

  @override
  String get questionsUid {
    _$questionsUidAtom.reportRead();
    return super.questionsUid;
  }

  @override
  set questionsUid(String value) {
    _$questionsUidAtom.reportWrite(value, super.questionsUid, () {
      super.questionsUid = value;
    });
  }

  late final _$isQuitAtom = Atom(name: '_ExamStore.isQuit', context: context);

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

  late final _$getExamAsyncAction =
      AsyncAction('_ExamStore.getExam', context: context);

  @override
  Future<dynamic> getExam() {
    return _$getExamAsyncAction.run(() => super.getExam());
  }

  late final _$updateProgressAsyncAction =
      AsyncAction('_ExamStore.updateProgress', context: context);

  @override
  Future<dynamic> updateProgress(DateTime start, DateTime end) {
    return _$updateProgressAsyncAction
        .run(() => super.updateProgress(start, end));
  }

  late final _$_ExamStoreActionController =
      ActionController(name: '_ExamStore', context: context);

  @override
  ExerciseResult? getExerciseResult() {
    final _$actionInfo = _$_ExamStoreActionController.startAction(
        name: '_ExamStore.getExerciseResult');
    try {
      return super.getExerciseResult();
    } finally {
      _$_ExamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuit(QuitOverlayResponse value) {
    final _$actionInfo =
        _$_ExamStoreActionController.startAction(name: '_ExamStore.setQuit');
    try {
      return super.setQuit(value);
    } finally {
      _$_ExamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuestionsUid(String uid) {
    final _$actionInfo = _$_ExamStoreActionController.startAction(
        name: '_ExamStore.setQuestionsUid');
    try {
      return super.setQuestionsUid(uid);
    } finally {
      _$_ExamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleLogout() {
    final _$actionInfo = _$_ExamStoreActionController.startAction(
        name: '_ExamStore.handleLogout');
    try {
      return super.handleLogout();
    } finally {
      _$_ExamStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchQuestionsFuture: ${fetchQuestionsFuture},
saveUserResult: ${saveUserResult},
fetchExerciseAnswerFuture: ${fetchExerciseAnswerFuture},
uploadImagesFuture: ${uploadImagesFuture},
exam: ${exam},
exerciseResult: ${exerciseResult},
isUploadingImages: ${isUploadingImages},
success: ${success},
isAuthorized: ${isAuthorized},
questionsUid: ${questionsUid},
isQuit: ${isQuit},
loading: ${loading},
saving: ${saving}
    ''';
  }
}
