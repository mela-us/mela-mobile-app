// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_proposed_new_suggestion_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListProposedNewSuggestionStore
    on _ListProposedNewSuggestionStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ListProposedNewSuggestionStore.isLoading', context: context);

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
      name: '_ListProposedNewSuggestionStore.isUnAuthorized', context: context);

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

  late final _$suggestionListAtom = Atom(
      name: '_ListProposedNewSuggestionStore.suggestionList', context: context);

  @override
  ListSuggestion? get suggestionList {
    _$suggestionListAtom.reportRead();
    return super.suggestionList;
  }

  @override
  set suggestionList(ListSuggestion? value) {
    _$suggestionListAtom.reportWrite(value, super.suggestionList, () {
      super.suggestionList = value;
    });
  }

  late final _$getProposedNewLectureAsyncAction = AsyncAction(
      '_ListProposedNewSuggestionStore.getProposedNewLecture',
      context: context);

  @override
  Future<void> getProposedNewLecture() {
    return _$getProposedNewLectureAsyncAction
        .run(() => super.getProposedNewLecture());
  }

  late final _$_ListProposedNewSuggestionStoreActionController =
      ActionController(
          name: '_ListProposedNewSuggestionStore', context: context);

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ListProposedNewSuggestionStoreActionController
        .startAction(name: '_ListProposedNewSuggestionStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ListProposedNewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUnAuthorized(bool value) {
    final _$actionInfo = _$_ListProposedNewSuggestionStoreActionController
        .startAction(name: '_ListProposedNewSuggestionStore.setUnAuthorized');
    try {
      return super.setUnAuthorized(value);
    } finally {
      _$_ListProposedNewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isUnAuthorized: ${isUnAuthorized},
suggestionList: ${suggestionList}
    ''';
  }
}
