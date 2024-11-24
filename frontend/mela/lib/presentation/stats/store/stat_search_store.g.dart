// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatSearchStore on _StatSearchStore, Store {
  Computed<bool>? _$isLoadingSearchComputed;

  @override
  bool get isLoadingSearch =>
      (_$isLoadingSearchComputed ??= Computed<bool>(() => super.isLoadingSearch,
              name: '_StatSearchStore.isLoadingSearch'))
          .value;
  Computed<bool>? _$isLoadingHistorySearchComputed;

  @override
  bool get isLoadingHistorySearch => (_$isLoadingHistorySearchComputed ??=
          Computed<bool>(() => super.isLoadingHistorySearch,
              name: '_StatSearchStore.isLoadingHistorySearch'))
      .value;

  late final _$isSearchedAtom =
      Atom(name: '_StatSearchStore.isSearched', context: context);

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
      Atom(name: '_StatSearchStore.isFiltered', context: context);

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

  late final _$errorStringAtom =
      Atom(name: '_StatSearchStore.errorString', context: context);

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
      Atom(name: '_StatSearchStore.searchHistory', context: context);

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

  late final _$listAfterSearchingAndFilteringAtom = Atom(
      name: '_StatSearchStore.listAfterSearchingAndFiltering',
      context: context);

  @override
  ProgressList? get listAfterSearchingAndFiltering {
    _$listAfterSearchingAndFilteringAtom.reportRead();
    return super.listAfterSearchingAndFiltering;
  }

  @override
  set listAfterSearchingAndFiltering(ProgressList? value) {
    _$listAfterSearchingAndFilteringAtom
        .reportWrite(value, super.listAfterSearchingAndFiltering, () {
      super.listAfterSearchingAndFiltering = value;
    });
  }

  late final _$listAfterSearchingAtom =
      Atom(name: '_StatSearchStore.listAfterSearching', context: context);

  @override
  ProgressList? get listAfterSearching {
    _$listAfterSearchingAtom.reportRead();
    return super.listAfterSearching;
  }

  @override
  set listAfterSearching(ProgressList? value) {
    _$listAfterSearchingAtom.reportWrite(value, super.listAfterSearching, () {
      super.listAfterSearching = value;
    });
  }

  late final _$fetchAfterSearchingFutureAtom = Atom(
      name: '_StatSearchStore.fetchAfterSearchingFuture', context: context);

  @override
  ObservableFuture<ProgressList?> get fetchAfterSearchingFuture {
    _$fetchAfterSearchingFutureAtom.reportRead();
    return super.fetchAfterSearchingFuture;
  }

  @override
  set fetchAfterSearchingFuture(ObservableFuture<ProgressList?> value) {
    _$fetchAfterSearchingFutureAtom
        .reportWrite(value, super.fetchAfterSearchingFuture, () {
      super.fetchAfterSearchingFuture = value;
    });
  }

  late final _$fetchHistorySearchFutureAtom =
      Atom(name: '_StatSearchStore.fetchHistorySearchFuture', context: context);

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

  late final _$getStatSearchHistoryAsyncAction =
      AsyncAction('_StatSearchStore.getStatSearchHistory', context: context);

  @override
  Future<dynamic> getStatSearchHistory() {
    return _$getStatSearchHistoryAsyncAction
        .run(() => super.getStatSearchHistory());
  }

  late final _$getAfterSearchAsyncAction =
      AsyncAction('_StatSearchStore.getAfterSearch', context: context);

  @override
  Future<dynamic> getAfterSearch(String txtSearching) {
    return _$getAfterSearchAsyncAction
        .run(() => super.getAfterSearch(txtSearching));
  }

  late final _$_StatSearchStoreActionController =
      ActionController(name: '_StatSearchStore', context: context);

  @override
  void updateAfterSeachingAndFiltering(ProgressList? value) {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.updateAfterSeachingAndFiltering');
    try {
      return super.updateAfterSeachingAndFiltering(value);
    } finally {
      _$_StatSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIsSearched() {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.toggleIsSearched');
    try {
      return super.toggleIsSearched();
    } finally {
      _$_StatSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetIsSearched() {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.resetIsSearched');
    try {
      return super.resetIsSearched();
    } finally {
      _$_StatSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFiltered(bool value) {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.setIsFiltered');
    try {
      return super.setIsFiltered(value);
    } finally {
      _$_StatSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetErrorString() {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.resetErrorString');
    try {
      return super.resetErrorString();
    } finally {
      _$_StatSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSearched: ${isSearched},
isFiltered: ${isFiltered},
errorString: ${errorString},
searchHistory: ${searchHistory},
listAfterSearchingAndFiltering: ${listAfterSearchingAndFiltering},
listAfterSearching: ${listAfterSearching},
fetchAfterSearchingFuture: ${fetchAfterSearchingFuture},
fetchHistorySearchFuture: ${fetchHistorySearchFuture},
isLoadingSearch: ${isLoadingSearch},
isLoadingHistorySearch: ${isLoadingHistorySearch}
    ''';
  }
}
