// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  Computed<bool>? _$isLoadingSearchComputed;

  @override
  bool get isLoadingSearch =>
      (_$isLoadingSearchComputed ??= Computed<bool>(() => super.isLoadingSearch,
              name: '_SearchStore.isLoadingSearch'))
          .value;
  Computed<bool>? _$isLoadingHistorySearchComputed;

  @override
  bool get isLoadingHistorySearch => (_$isLoadingHistorySearchComputed ??=
          Computed<bool>(() => super.isLoadingHistorySearch,
              name: '_SearchStore.isLoadingHistorySearch'))
      .value;

  late final _$isSearchedAtom =
      Atom(name: '_SearchStore.isSearched', context: context);

  @override
  bool get isSearched {
    _$isSearchedAtom.reportRead();
    return super.isSearched;
  }

  @override
  set isSearched(bool value) {
    _$isSearchedAtom.reportWrite(value, super.isSearched, () {
      super.isSearched = value;
    });
  }

  late final _$isFilteredAtom =
      Atom(name: '_SearchStore.isFiltered', context: context);

  @override
  bool get isFiltered {
    _$isFilteredAtom.reportRead();
    return super.isFiltered;
  }

  @override
  set isFiltered(bool value) {
    _$isFilteredAtom.reportWrite(value, super.isFiltered, () {
      super.isFiltered = value;
    });
  }

  late final _$isUnAuthorizedAtom =
      Atom(name: '_SearchStore.isUnAuthorized', context: context);

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
      Atom(name: '_SearchStore.errorString', context: context);

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

  late final _$searchHistoryAtom =
      Atom(name: '_SearchStore.searchHistory', context: context);

  @override
  List<String>? get searchHistory {
    _$searchHistoryAtom.reportRead();
    return super.searchHistory;
  }

  @override
  set searchHistory(List<String>? value) {
    _$searchHistoryAtom.reportWrite(value, super.searchHistory, () {
      super.searchHistory = value;
    });
  }

  late final _$lecturesAfterSearchingAndFilteringAtom = Atom(
      name: '_SearchStore.lecturesAfterSearchingAndFiltering',
      context: context);

  @override
  LectureList? get lecturesAfterSearchingAndFiltering {
    _$lecturesAfterSearchingAndFilteringAtom.reportRead();
    return super.lecturesAfterSearchingAndFiltering;
  }

  @override
  set lecturesAfterSearchingAndFiltering(LectureList? value) {
    _$lecturesAfterSearchingAndFilteringAtom
        .reportWrite(value, super.lecturesAfterSearchingAndFiltering, () {
      super.lecturesAfterSearchingAndFiltering = value;
    });
  }

  late final _$lecturesAfterSearchingAtom =
      Atom(name: '_SearchStore.lecturesAfterSearching', context: context);

  @override
  LectureList? get lecturesAfterSearching {
    _$lecturesAfterSearchingAtom.reportRead();
    return super.lecturesAfterSearching;
  }

  @override
  set lecturesAfterSearching(LectureList? value) {
    _$lecturesAfterSearchingAtom
        .reportWrite(value, super.lecturesAfterSearching, () {
      super.lecturesAfterSearching = value;
    });
  }

  late final _$fetchLecturesAfterSearchingFutureAtom = Atom(
      name: '_SearchStore.fetchLecturesAfterSearchingFuture', context: context);

  @override
  ObservableFuture<LectureList?> get fetchLecturesAfterSearchingFuture {
    _$fetchLecturesAfterSearchingFutureAtom.reportRead();
    return super.fetchLecturesAfterSearchingFuture;
  }

  @override
  set fetchLecturesAfterSearchingFuture(ObservableFuture<LectureList?> value) {
    _$fetchLecturesAfterSearchingFutureAtom
        .reportWrite(value, super.fetchLecturesAfterSearchingFuture, () {
      super.fetchLecturesAfterSearchingFuture = value;
    });
  }

  late final _$fetchHistorySearchFutureAtom =
      Atom(name: '_SearchStore.fetchHistorySearchFuture', context: context);

  @override
  ObservableFuture<List<String>?> get fetchHistorySearchFuture {
    _$fetchHistorySearchFutureAtom.reportRead();
    return super.fetchHistorySearchFuture;
  }

  @override
  set fetchHistorySearchFuture(ObservableFuture<List<String>?> value) {
    _$fetchHistorySearchFutureAtom
        .reportWrite(value, super.fetchHistorySearchFuture, () {
      super.fetchHistorySearchFuture = value;
    });
  }

  late final _$getHistorySearchListAsyncAction =
      AsyncAction('_SearchStore.getHistorySearchList', context: context);

  @override
  Future<dynamic> getHistorySearchList() {
    return _$getHistorySearchListAsyncAction
        .run(() => super.getHistorySearchList());
  }

  late final _$getLecturesAfterSearchAsyncAction =
      AsyncAction('_SearchStore.getLecturesAfterSearch', context: context);

  @override
  Future<dynamic> getLecturesAfterSearch(String txtSearching) {
    return _$getLecturesAfterSearchAsyncAction
        .run(() => super.getLecturesAfterSearch(txtSearching));
  }

  late final _$_SearchStoreActionController =
      ActionController(name: '_SearchStore', context: context);

  @override
  void updateLectureAfterSeachingAndFiltering(LectureList? value) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.updateLectureAfterSeachingAndFiltering');
    try {
      return super.updateLectureAfterSeachingAndFiltering(value);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIsSearched() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.toggleIsSearched');
    try {
      return super.toggleIsSearched();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetIsSearched() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.resetIsSearched');
    try {
      return super.resetIsSearched();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFiltered(bool value) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setIsFiltered');
    try {
      return super.setIsFiltered(value);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorString() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSearched: ${isSearched},
isFiltered: ${isFiltered},
isUnAuthorized: ${isUnAuthorized},
errorString: ${errorString},
searchHistory: ${searchHistory},
lecturesAfterSearchingAndFiltering: ${lecturesAfterSearchingAndFiltering},
lecturesAfterSearching: ${lecturesAfterSearching},
fetchLecturesAfterSearchingFuture: ${fetchLecturesAfterSearchingFuture},
fetchHistorySearchFuture: ${fetchHistorySearchFuture},
isLoadingSearch: ${isLoadingSearch},
isLoadingHistorySearch: ${isLoadingHistorySearch}
    ''';
  }
}
