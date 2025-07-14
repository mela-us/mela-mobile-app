// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TutorStore on _TutorStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_TutorStore.loading'))
      .value;

  late final _$fetchLevelsFutureAtom =
      Atom(name: '_TutorStore.fetchLevelsFuture', context: context);

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

  late final _$isUnAuthorizedAtom =
      Atom(name: '_TutorStore.isUnAuthorized', context: context);

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

  late final _$errorStringAtom =
      Atom(name: '_TutorStore.errorString', context: context);

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

  late final _$levelListAtom =
      Atom(name: '_TutorStore.levelList', context: context);

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

  late final _$getLevelsAsyncAction =
      AsyncAction('_TutorStore.getLevels', context: context);

  @override
  Future<dynamic> getLevels() {
    return _$getLevelsAsyncAction.run(() => super.getLevels());
  }

  late final _$_TutorStoreActionController =
      ActionController(name: '_TutorStore', context: context);

  @override
  void resetErrorString() {
    final _$actionInfo = _$_TutorStoreActionController.startAction(
        name: '_TutorStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_TutorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchLevelsFuture: ${fetchLevelsFuture},
isUnAuthorized: ${isUnAuthorized},
errorString: ${errorString},
levelList: ${levelList},
loading: ${loading}
    ''';
  }
}
