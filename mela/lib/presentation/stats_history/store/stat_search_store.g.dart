// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatSearchStore on _StatSearchStore, Store {
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
  ObservableList<String> get searchHistory {
    _$searchHistoryAtom.reportRead();
    return super.searchHistory;
  }

  @override
  set searchHistory(ObservableList<String> value) {
    _$searchHistoryAtom.reportWrite(value, super.searchHistory, () {
      super.searchHistory = value;
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

  late final _$fetchUpdateHistoryAtom =
      Atom(name: '_StatSearchStore.fetchUpdateHistory', context: context);

  @override
  ObservableFuture<void> get fetchUpdateHistory {
    _$fetchUpdateHistoryAtom.reportRead();
    return super.fetchUpdateHistory;
  }

  @override
  set fetchUpdateHistory(ObservableFuture<void> value) {
    _$fetchUpdateHistoryAtom.reportWrite(value, super.fetchUpdateHistory, () {
      super.fetchUpdateHistory = value;
    });
  }

  late final _$getStatSearchHistoryAsyncAction =
      AsyncAction('_StatSearchStore.getStatSearchHistory', context: context);

  @override
  Future<dynamic> getStatSearchHistory() {
    return _$getStatSearchHistoryAsyncAction
        .run(() => super.getStatSearchHistory());
  }

  late final _$updateStatSearchHistoryAsyncAction =
      AsyncAction('_StatSearchStore.updateStatSearchHistory', context: context);

  @override
  Future<dynamic> updateStatSearchHistory() {
    return _$updateStatSearchHistoryAsyncAction
        .run(() => super.updateStatSearchHistory());
  }

  late final _$_StatSearchStoreActionController =
      ActionController(name: '_StatSearchStore', context: context);

  @override
  void removeSearchHistoryItem(int index) {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.removeSearchHistoryItem');
    try {
      return super.removeSearchHistoryItem(index);
    } finally {
      _$_StatSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSearchHistoryItem(String item) {
    final _$actionInfo = _$_StatSearchStoreActionController.startAction(
        name: '_StatSearchStore.addSearchHistoryItem');
    try {
      return super.addSearchHistoryItem(item);
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
fetchHistorySearchFuture: ${fetchHistorySearchFuture},
fetchUpdateHistory: ${fetchUpdateHistory},
isLoadingHistorySearch: ${isLoadingHistorySearch}
    ''';
  }
}
