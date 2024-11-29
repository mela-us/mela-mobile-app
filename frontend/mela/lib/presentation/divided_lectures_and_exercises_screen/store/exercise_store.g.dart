// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExerciseStore on _ExerciseStore, Store {
  Computed<bool>? _$isGetExercisesLoadingComputed;

  @override
  bool get isGetExercisesLoading => (_$isGetExercisesLoadingComputed ??=
          Computed<bool>(() => super.isGetExercisesLoading,
              name: '_ExerciseStore.isGetExercisesLoading'))
      .value;

  late final _$currentLectureAtom =
      Atom(name: '_ExerciseStore.currentLecture', context: context);

  @override
  Lecture? get currentLecture {
    _$currentLectureAtom.reportRead();
    return super.currentLecture;
  }

  @override
  set currentLecture(Lecture? value) {
    _$currentLectureAtom.reportWrite(value, super.currentLecture, () {
      super.currentLecture = value;
    });
  }

  late final _$errorStringAtom =
      Atom(name: '_ExerciseStore.errorString', context: context);

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

  late final _$exerciseListAtom =
      Atom(name: '_ExerciseStore.exerciseList', context: context);

  @override
  ExerciseList? get exerciseList {
    _$exerciseListAtom.reportRead();
    return super.exerciseList;
  }

  @override
  set exerciseList(ExerciseList? value) {
    _$exerciseListAtom.reportWrite(value, super.exerciseList, () {
      super.exerciseList = value;
    });
  }

  late final _$dividedLectureListAtom =
      Atom(name: '_ExerciseStore.dividedLectureList', context: context);

  @override
  DividedLectureList? get dividedLectureList {
    _$dividedLectureListAtom.reportRead();
    return super.dividedLectureList;
  }

  @override
  set dividedLectureList(DividedLectureList? value) {
    _$dividedLectureListAtom.reportWrite(value, super.dividedLectureList, () {
      super.dividedLectureList = value;
    });
  }

  late final _$fetchExercisesFutureAtom =
      Atom(name: '_ExerciseStore.fetchExercisesFuture', context: context);

  @override
  ObservableFuture<ExerciseList?> get fetchExercisesFuture {
    _$fetchExercisesFutureAtom.reportRead();
    return super.fetchExercisesFuture;
  }

  @override
  set fetchExercisesFuture(ObservableFuture<ExerciseList?> value) {
    _$fetchExercisesFutureAtom.reportWrite(value, super.fetchExercisesFuture,
        () {
      super.fetchExercisesFuture = value;
    });
  }

  late final _$fetchDividedLecturesFutureAtom =
      Atom(name: '_ExerciseStore.fetchDividedLecturesFuture', context: context);

  @override
  ObservableFuture<DividedLectureList?> get fetchDividedLecturesFuture {
    _$fetchDividedLecturesFutureAtom.reportRead();
    return super.fetchDividedLecturesFuture;
  }

  @override
  set fetchDividedLecturesFuture(ObservableFuture<DividedLectureList?> value) {
    _$fetchDividedLecturesFutureAtom
        .reportWrite(value, super.fetchDividedLecturesFuture, () {
      super.fetchDividedLecturesFuture = value;
    });
  }

  late final _$getExercisesByLectureIdAsyncAction =
      AsyncAction('_ExerciseStore.getExercisesByLectureId', context: context);

  @override
  Future<dynamic> getExercisesByLectureId() {
    return _$getExercisesByLectureIdAsyncAction
        .run(() => super.getExercisesByLectureId());
  }

  late final _$getDividedLecturesByLectureIdAsyncAction = AsyncAction(
      '_ExerciseStore.getDividedLecturesByLectureId',
      context: context);

  @override
  Future<dynamic> getDividedLecturesByLectureId() {
    return _$getDividedLecturesByLectureIdAsyncAction
        .run(() => super.getDividedLecturesByLectureId());
  }

  late final _$_ExerciseStoreActionController =
      ActionController(name: '_ExerciseStore', context: context);

  @override
  void setCurrentLecture(Lecture mLecture) {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.setCurrentLecture');
    try {
      return super.setCurrentLecture(mLecture);
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorString() {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentLecture: ${currentLecture},
errorString: ${errorString},
exerciseList: ${exerciseList},
dividedLectureList: ${dividedLectureList},
fetchExercisesFuture: ${fetchExercisesFuture},
fetchDividedLecturesFuture: ${fetchDividedLecturesFuture},
isGetExercisesLoading: ${isGetExercisesLoading}
    ''';
  }
}
