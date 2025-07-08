// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryStore on _HistoryStore, Store {
  Computed<bool>? _$iisLoadingComputed;

  @override
  bool get iisLoading =>
      (_$iisLoadingComputed ??= Computed<bool>(() => super.iisLoading,
              name: '_HistoryStore.iisLoading'))
          .value;
  Computed<DateTime?>? _$timestampComputed;

  @override
  DateTime? get timestamp =>
      (_$timestampComputed ??= Computed<DateTime?>(() => super.timestamp,
              name: '_HistoryStore.timestamp'))
          .value;
  Computed<bool>? _$hasMoreComputed;

  @override
  bool get hasMore => (_$hasMoreComputed ??=
          Computed<bool>(() => super.hasMore, name: '_HistoryStore.hasMore'))
      .value;

  late final _$convsAtom = Atom(name: '_HistoryStore.convs', context: context);

  @override
  ObservableList<HistoryItem> get convs {
    _$convsAtom.reportRead();
    return super.convs;
  }

  @override
  set convs(ObservableList<HistoryItem> value) {
    _$convsAtom.reportWrite(value, super.convs, () {
      super.convs = value;
    });
  }

  late final _$responseAtom =
      Atom(name: '_HistoryStore.response', context: context);

  @override
  HistoryResponse? get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(HistoryResponse? value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HistoryStore.isLoading', context: context);

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

  late final _$isLoadMoreAtom =
      Atom(name: '_HistoryStore.isLoadMore', context: context);

  @override
  bool get isLoadMore {
    _$isLoadMoreAtom.reportRead();
    return super.isLoadMore;
  }

  @override
  set isLoadMore(bool value) {
    _$isLoadMoreAtom.reportWrite(value, super.isLoadMore, () {
      super.isLoadMore = value;
    });
  }

  late final _$isUnauthorizedAtom =
      Atom(name: '_HistoryStore.isUnauthorized', context: context);

  @override
  bool get isUnauthorized {
    _$isUnauthorizedAtom.reportRead();
    return super.isUnauthorized;
  }

  @override
  set isUnauthorized(bool value) {
    _$isUnauthorizedAtom.reportWrite(value, super.isUnauthorized, () {
      super.isUnauthorized = value;
    });
  }

  late final _$firstTimeGetHistoryAsyncAction =
      AsyncAction('_HistoryStore.firstTimeGetHistory', context: context);

  @override
  Future<void> firstTimeGetHistory() {
    return _$firstTimeGetHistoryAsyncAction
        .run(() => super.firstTimeGetHistory());
  }

  late final _$getMoreHistoryAsyncAction =
      AsyncAction('_HistoryStore.getMoreHistory', context: context);

  @override
  Future<void> getMoreHistory(DateTime timestamp) {
    return _$getMoreHistoryAsyncAction
        .run(() => super.getMoreHistory(timestamp));
  }

  late final _$deleteConversationAsyncAction =
      AsyncAction('_HistoryStore.deleteConversation', context: context);

  @override
  Future<void> deleteConversation(String conversationId) {
    return _$deleteConversationAsyncAction
        .run(() => super.deleteConversation(conversationId));
  }

  @override
  String toString() {
    return '''
convs: ${convs},
response: ${response},
isLoading: ${isLoading},
isLoadMore: ${isLoadMore},
isUnauthorized: ${isUnauthorized},
iisLoading: ${iisLoading},
timestamp: ${timestamp},
hasMore: ${hasMore}
    ''';
  }
}
