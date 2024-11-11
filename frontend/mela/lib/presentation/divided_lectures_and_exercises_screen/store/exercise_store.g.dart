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

  late final _$lectureIdAtom =
      Atom(name: '_ExerciseStore.lectureId', context: context);

  @override
  int get lectureId {
    _$lectureIdAtom.reportRead();
    return super.lectureId;
  }

  @override
  set lectureId(int value) {
    _$lectureIdAtom.reportWrite(value, super.lectureId, () {
      super.lectureId = value;
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

  late final _$getExercisesByLectureIdAsyncAction =
      AsyncAction('_ExerciseStore.getExercisesByLectureId', context: context);

  @override
  Future<dynamic> getExercisesByLectureId() {
    return _$getExercisesByLectureIdAsyncAction
        .run(() => super.getExercisesByLectureId());
  }

  late final _$_ExerciseStoreActionController =
      ActionController(name: '_ExerciseStore', context: context);

  @override
  void setLectureId(int mLectureId) {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.setLectureId');
    try {
      return super.setLectureId(mLectureId);
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetLectureId() {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.resetLectureId');
    try {
      return super.resetLectureId();
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lectureId: ${lectureId},
exerciseList: ${exerciseList},
fetchExercisesFuture: ${fetchExercisesFuture},
isGetExercisesLoading: ${isGetExercisesLoading}
    ''';
  }
}
