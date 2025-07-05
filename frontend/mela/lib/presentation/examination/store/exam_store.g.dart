// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExamStore on _ExamStore, Store {
  Computed<bool>? _$isExamAvailableComputed;

  @override
  bool get isExamAvailable =>
      (_$isExamAvailableComputed ??= Computed<bool>(() => super.isExamAvailable,
              name: '_ExamStore.isExamAvailable'))
          .value;
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

  late final _$fetchExamFutureAtom =
      Atom(name: '_ExamStore.fetchExamFuture', context: context);

  @override
  ObservableFuture<ExamModel?> get fetchExamFuture {
    _$fetchExamFutureAtom.reportRead();
    return super.fetchExamFuture;
  }

  @override
  set fetchExamFuture(ObservableFuture<ExamModel?> value) {
    _$fetchExamFutureAtom.reportWrite(value, super.fetchExamFuture, () {
      super.fetchExamFuture = value;
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

  late final _$fetchExamAsyncAction =
      AsyncAction('_ExamStore.fetchExam', context: context);

  @override
  Future<void> fetchExam() {
    return _$fetchExamAsyncAction.run(() => super.fetchExam());
  }

  late final _$_ExamStoreActionController =
      ActionController(name: '_ExamStore', context: context);

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
  String toString() {
    return '''
fetchExamFuture: ${fetchExamFuture},
saveUserResult: ${saveUserResult},
exam: ${exam},
success: ${success},
isAuthorized: ${isAuthorized},
isQuit: ${isQuit},
isExamAvailable: ${isExamAvailable},
loading: ${loading},
saving: ${saving}
    ''';
  }
}
