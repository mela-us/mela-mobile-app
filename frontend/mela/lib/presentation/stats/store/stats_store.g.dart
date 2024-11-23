// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatisticsStore on _StatisticsStore, Store {
  Computed<bool>? _$progressLoadingComputed;

  @override
  bool get progressLoading =>
      (_$progressLoadingComputed ??= Computed<bool>(() => super.progressLoading,
              name: '_StatisticsStore.progressLoading'))
          .value;
  Computed<bool>? _$detailedProgressLoadingComputed;

  @override
  bool get detailedProgressLoading => (_$detailedProgressLoadingComputed ??=
          Computed<bool>(() => super.detailedProgressLoading,
              name: '_StatisticsStore.detailedProgressLoading'))
      .value;

  late final _$fetchProgressFutureAtom =
      Atom(name: '_StatisticsStore.fetchProgressFuture', context: context);

  @override
  ObservableFuture<ProgressList?> get fetchProgressFuture {
    _$fetchProgressFutureAtom.reportRead();
    return super.fetchProgressFuture;
  }

  @override
  set fetchProgressFuture(ObservableFuture<ProgressList?> value) {
    _$fetchProgressFutureAtom.reportWrite(value, super.fetchProgressFuture, () {
      super.fetchProgressFuture = value;
    });
  }

  late final _$fetchDetailedProgressFutureAtom = Atom(
      name: '_StatisticsStore.fetchDetailedProgressFuture', context: context);

  @override
  ObservableFuture<DetailedProgressList?> get fetchDetailedProgressFuture {
    _$fetchDetailedProgressFutureAtom.reportRead();
    return super.fetchDetailedProgressFuture;
  }

  @override
  set fetchDetailedProgressFuture(
      ObservableFuture<DetailedProgressList?> value) {
    _$fetchDetailedProgressFutureAtom
        .reportWrite(value, super.fetchDetailedProgressFuture, () {
      super.fetchDetailedProgressFuture = value;
    });
  }

  late final _$progressListAtom =
      Atom(name: '_StatisticsStore.progressList', context: context);

  @override
  ProgressList? get progressList {
    _$progressListAtom.reportRead();
    return super.progressList;
  }

  @override
  set progressList(ProgressList? value) {
    _$progressListAtom.reportWrite(value, super.progressList, () {
      super.progressList = value;
    });
  }

  late final _$detailedProgressListAtom =
      Atom(name: '_StatisticsStore.detailedProgressList', context: context);

  @override
  DetailedProgressList? get detailedProgressList {
    _$detailedProgressListAtom.reportRead();
    return super.detailedProgressList;
  }

  @override
  set detailedProgressList(DetailedProgressList? value) {
    _$detailedProgressListAtom.reportWrite(value, super.detailedProgressList,
        () {
      super.detailedProgressList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_StatisticsStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$getProgressListAsyncAction =
      AsyncAction('_StatisticsStore.getProgressList', context: context);

  @override
  Future<dynamic> getProgressList() {
    return _$getProgressListAsyncAction.run(() => super.getProgressList());
  }

  late final _$getDetailedProgressListAsyncAction =
      AsyncAction('_StatisticsStore.getDetailedProgressList', context: context);

  @override
  Future<dynamic> getDetailedProgressList() {
    return _$getDetailedProgressListAsyncAction
        .run(() => super.getDetailedProgressList());
  }

  @override
  String toString() {
    return '''
fetchProgressFuture: ${fetchProgressFuture},
fetchDetailedProgressFuture: ${fetchDetailedProgressFuture},
progressList: ${progressList},
detailedProgressList: ${detailedProgressList},
success: ${success},
progressLoading: ${progressLoading},
detailedProgressLoading: ${detailedProgressLoading}
    ''';
  }
}
