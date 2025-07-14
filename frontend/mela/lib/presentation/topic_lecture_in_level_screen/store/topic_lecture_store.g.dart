// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_lecture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TopicLectureStore on _TopicLectureStore, Store {
  Computed<bool>? _$isGetTopicLectureLoadingComputed;

  @override
  bool get isGetTopicLectureLoading => (_$isGetTopicLectureLoadingComputed ??=
          Computed<bool>(() => super.isGetTopicLectureLoading,
              name: '_TopicLectureStore.isGetTopicLectureLoading'))
      .value;

  late final _$currentLevelAtom =
      Atom(name: '_TopicLectureStore.currentLevel', context: context);

  @override
  Level? get currentLevel {
    _$currentLevelAtom.reportRead();
    return super.currentLevel;
  }

  @override
  set currentLevel(Level? value) {
    _$currentLevelAtom.reportWrite(value, super.currentLevel, () {
      super.currentLevel = value;
    });
  }

  late final _$errorStringAtom =
      Atom(name: '_TopicLectureStore.errorString', context: context);

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
      Atom(name: '_TopicLectureStore.isUnAuthorized', context: context);

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

  late final _$topicLectureInLevelListAtom = Atom(
      name: '_TopicLectureStore.topicLectureInLevelList', context: context);

  @override
  TopicLectureInLevelList? get topicLectureInLevelList {
    _$topicLectureInLevelListAtom.reportRead();
    return super.topicLectureInLevelList;
  }

  @override
  set topicLectureInLevelList(TopicLectureInLevelList? value) {
    _$topicLectureInLevelListAtom
        .reportWrite(value, super.topicLectureInLevelList, () {
      super.topicLectureInLevelList = value;
    });
  }

  late final _$fetchTopicLectureFutureAtom = Atom(
      name: '_TopicLectureStore.fetchTopicLectureFuture', context: context);

  @override
  ObservableFuture<TopicLectureInLevelList?> get fetchTopicLectureFuture {
    _$fetchTopicLectureFutureAtom.reportRead();
    return super.fetchTopicLectureFuture;
  }

  @override
  set fetchTopicLectureFuture(
      ObservableFuture<TopicLectureInLevelList?> value) {
    _$fetchTopicLectureFutureAtom
        .reportWrite(value, super.fetchTopicLectureFuture, () {
      super.fetchTopicLectureFuture = value;
    });
  }

  late final _$getListTopicLectureInLevelAsyncAction = AsyncAction(
      '_TopicLectureStore.getListTopicLectureInLevel',
      context: context);

  @override
  Future<dynamic> getListTopicLectureInLevel() {
    return _$getListTopicLectureInLevelAsyncAction
        .run(() => super.getListTopicLectureInLevel());
  }

  late final _$_TopicLectureStoreActionController =
      ActionController(name: '_TopicLectureStore', context: context);

  @override
  void setCurrentLevel(Level mCurrentLevel) {
    final _$actionInfo = _$_TopicLectureStoreActionController.startAction(
        name: '_TopicLectureStore.setCurrentLevel');
    try {
      return super.setCurrentLevel(mCurrentLevel);
    } finally {
      _$_TopicLectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetTopic() {
    final _$actionInfo = _$_TopicLectureStoreActionController.startAction(
        name: '_TopicLectureStore.resetTopic');
    try {
      return super.resetTopic();
    } finally {
      _$_TopicLectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorString() {
    final _$actionInfo = _$_TopicLectureStoreActionController.startAction(
        name: '_TopicLectureStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_TopicLectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentLevel: ${currentLevel},
errorString: ${errorString},
isUnAuthorized: ${isUnAuthorized},
topicLectureInLevelList: ${topicLectureInLevelList},
fetchTopicLectureFuture: ${fetchTopicLectureFuture},
isGetTopicLectureLoading: ${isGetTopicLectureLoading}
    ''';
  }
}
