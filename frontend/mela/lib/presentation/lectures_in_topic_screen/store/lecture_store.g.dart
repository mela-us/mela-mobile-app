// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LectureStore on _LectureStore, Store {
  Computed<bool>? _$isGetLecturesLoadingComputed;

  @override
  bool get isGetLecturesLoading => (_$isGetLecturesLoadingComputed ??=
          Computed<bool>(() => super.isGetLecturesLoading,
              name: '_LectureStore.isGetLecturesLoading'))
      .value;

  late final _$currentTopicAtom =
      Atom(name: '_LectureStore.currentTopic', context: context);

  @override
  Topic? get currentTopic {
    _$currentTopicAtom.reportRead();
    return super.currentTopic;
  }

  @override
  set currentTopic(Topic? value) {
    _$currentTopicAtom.reportWrite(value, super.currentTopic, () {
      super.currentTopic = value;
    });
  }

  late final _$errorStringAtom =
      Atom(name: '_LectureStore.errorString', context: context);

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
      Atom(name: '_LectureStore.isUnAuthorized', context: context);

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

  late final _$lectureListAtom =
      Atom(name: '_LectureStore.lectureList', context: context);

  @override
  LectureList? get lectureList {
    _$lectureListAtom.reportRead();
    return super.lectureList;
  }

  @override
  set lectureList(LectureList? value) {
    _$lectureListAtom.reportWrite(value, super.lectureList, () {
      super.lectureList = value;
    });
  }

  late final _$fetchLectureFutureAtom =
      Atom(name: '_LectureStore.fetchLectureFuture', context: context);

  @override
  ObservableFuture<LectureList?> get fetchLectureFuture {
    _$fetchLectureFutureAtom.reportRead();
    return super.fetchLectureFuture;
  }

  @override
  set fetchLectureFuture(ObservableFuture<LectureList?> value) {
    _$fetchLectureFutureAtom.reportWrite(value, super.fetchLectureFuture, () {
      super.fetchLectureFuture = value;
    });
  }

  late final _$getListLectureByTopicIdAndLevelIdAsyncAction = AsyncAction(
      '_LectureStore.getListLectureByTopicIdAndLevelId',
      context: context);

  @override
  Future<dynamic> getListLectureByTopicIdAndLevelId() {
    return _$getListLectureByTopicIdAndLevelIdAsyncAction
        .run(() => super.getListLectureByTopicIdAndLevelId());
  }

  late final _$_LectureStoreActionController =
      ActionController(name: '_LectureStore', context: context);

  @override
  void setCurrentTopic(Topic mCurrentTopic) {
    final _$actionInfo = _$_LectureStoreActionController.startAction(
        name: '_LectureStore.setCurrentTopic');
    try {
      return super.setCurrentTopic(mCurrentTopic);
    } finally {
      _$_LectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetTopic() {
    final _$actionInfo = _$_LectureStoreActionController.startAction(
        name: '_LectureStore.resetTopic');
    try {
      return super.resetTopic();
    } finally {
      _$_LectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorString() {
    final _$actionInfo = _$_LectureStoreActionController.startAction(
        name: '_LectureStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_LectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTopic: ${currentTopic},
errorString: ${errorString},
isUnAuthorized: ${isUnAuthorized},
lectureList: ${lectureList},
fetchLectureFuture: ${fetchLectureFuture},
isGetLecturesLoading: ${isGetLecturesLoading}
    ''';
  }
}
