// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LevelStore on _LevelStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_LevelStore.loading'))
      .value;

  late final _$lecturesAreLearningListAtom =
      Atom(name: '_LevelStore.lecturesAreLearningList', context: context);

  @override
  LectureList? get lecturesAreLearningList {
    _$lecturesAreLearningListAtom.reportRead();
    return super.lecturesAreLearningList;
  }

  @override
  set lecturesAreLearningList(LectureList? value) {
    _$lecturesAreLearningListAtom
        .reportWrite(value, super.lecturesAreLearningList, () {
      super.lecturesAreLearningList = value;
    });
  }

  late final _$levelListAtom =
      Atom(name: '_LevelStore.levelList', context: context);

  @override
  LevelList? get levelList {
    _$levelListAtom.reportRead();
    return super.levelList;
  }

  @override
  set levelList(LevelList? value) {
    _$levelListAtom.reportWrite(value, super.levelList, () {
      super.levelList = value;
    });
  }

  late final _$errorStringAtom =
      Atom(name: '_LevelStore.errorString', context: context);

  @override
  String get errorString {
    _$errorStringAtom.reportRead();
    return super.errorString;
  }

  @override
  set errorString(String value) {
    _$errorStringAtom.reportWrite(value, super.errorString, () {
      super.errorString = value;
    });
  }

  late final _$isUnAuthorizedAtom =
      Atom(name: '_LevelStore.isUnAuthorized', context: context);

  @override
  bool get isUnAuthorized {
    _$isUnAuthorizedAtom.reportRead();
    return super.isUnAuthorized;
  }

  @override
  set isUnAuthorized(bool value) {
    _$isUnAuthorizedAtom.reportWrite(value, super.isUnAuthorized, () {
      super.isUnAuthorized = value;
    });
  }

  late final _$fetchLecturesAreLearningFutureAtom = Atom(
      name: '_LevelStore.fetchLecturesAreLearningFuture', context: context);

  @override
  ObservableFuture<LectureList?> get fetchLecturesAreLearningFuture {
    _$fetchLecturesAreLearningFutureAtom.reportRead();
    return super.fetchLecturesAreLearningFuture;
  }

  @override
  set fetchLecturesAreLearningFuture(ObservableFuture<LectureList?> value) {
    _$fetchLecturesAreLearningFutureAtom
        .reportWrite(value, super.fetchLecturesAreLearningFuture, () {
      super.fetchLecturesAreLearningFuture = value;
    });
  }

  late final _$fetchLevelsFutureAtom =
      Atom(name: '_LevelStore.fetchLevelsFuture', context: context);

  @override
  ObservableFuture<LevelList?> get fetchLevelsFuture {
    _$fetchLevelsFutureAtom.reportRead();
    return super.fetchLevelsFuture;
  }

  @override
  set fetchLevelsFuture(ObservableFuture<LevelList?> value) {
    _$fetchLevelsFutureAtom.reportWrite(value, super.fetchLevelsFuture, () {
      super.fetchLevelsFuture = value;
    });
  }

  late final _$getAreLearningLecturesAsyncAction =
      AsyncAction('_LevelStore.getAreLearningLectures', context: context);

  @override
  Future<dynamic> getAreLearningLectures() {
    return _$getAreLearningLecturesAsyncAction
        .run(() => super.getAreLearningLectures());
  }

  late final _$getLevelsAsyncAction =
      AsyncAction('_LevelStore.getLevels', context: context);

  @override
  Future<dynamic> getLevels() {
    return _$getLevelsAsyncAction.run(() => super.getLevels());
  }

  late final _$_LevelStoreActionController =
      ActionController(name: '_LevelStore', context: context);

  @override
  void resetErrorString() {
    final _$actionInfo = _$_LevelStoreActionController.startAction(
        name: '_LevelStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_LevelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lecturesAreLearningList: ${lecturesAreLearningList},
levelList: ${levelList},
errorString: ${errorString},
isUnAuthorized: ${isUnAuthorized},
fetchLecturesAreLearningFuture: ${fetchLecturesAreLearningFuture},
fetchLevelsFuture: ${fetchLevelsFuture},
loading: ${loading}
    ''';
  }
}
