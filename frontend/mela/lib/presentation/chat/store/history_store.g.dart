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

  late final _$getConvHistoryAsyncAction =
      AsyncAction('_HistoryStore.getConvHistory', context: context);

  @override
  Future<void> getConvHistory() {
    return _$getConvHistoryAsyncAction.run(() => super.getConvHistory());
  }

  @override
  String toString() {
    return '''
convs: ${convs},
isLoading: ${isLoading},
iisLoading: ${iisLoading}
    ''';
  }
}
