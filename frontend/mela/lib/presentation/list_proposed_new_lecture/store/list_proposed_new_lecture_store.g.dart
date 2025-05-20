// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_proposed_new_lecture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListProposedNewLectureStore on _ListProposedNewLectureStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ListProposedNewLectureStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isUnAuthorizedAtom = Atom(
      name: '_ListProposedNewLectureStore.isUnAuthorized', context: context);

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
      Atom(name: '_ListProposedNewLectureStore.lectureList', context: context);

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

  late final _$getProposedNewLectureAsyncAction = AsyncAction(
      '_ListProposedNewLectureStore.getProposedNewLecture',
      context: context);

  @override
  Future<void> getProposedNewLecture() {
    return _$getProposedNewLectureAsyncAction
        .run(() => super.getProposedNewLecture());
  }

  late final _$_ListProposedNewLectureStoreActionController =
      ActionController(name: '_ListProposedNewLectureStore', context: context);

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ListProposedNewLectureStoreActionController
        .startAction(name: '_ListProposedNewLectureStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ListProposedNewLectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUnAuthorized(bool value) {
    final _$actionInfo = _$_ListProposedNewLectureStoreActionController
        .startAction(name: '_ListProposedNewLectureStore.setUnAuthorized');
    try {
      return super.setUnAuthorized(value);
    } finally {
      _$_ListProposedNewLectureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isUnAuthorized: ${isUnAuthorized},
lectureList: ${lectureList}
    ''';
  }
}
