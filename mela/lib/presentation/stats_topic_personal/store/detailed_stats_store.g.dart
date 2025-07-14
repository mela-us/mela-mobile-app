// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_stats_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailedStatStore on _DetailedStatStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_DetailedStatStore.loading'))
      .value;

  late final _$fetchFutureAtom =
      Atom(name: '_DetailedStatStore.fetchFuture', context: context);

  @override
  ObservableFuture<DetailedStatList?> get fetchFuture {
    _$fetchFutureAtom.reportRead();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<DetailedStatList?> value) {
    _$fetchFutureAtom.reportWrite(value, super.fetchFuture, () {
      super.fetchFuture = value;
    });
  }

  late final _$statsAtom =
      Atom(name: '_DetailedStatStore.stats', context: context);

  @override
  DetailedStatList? get stats {
    _$statsAtom.reportRead();
    return super.stats;
  }

  @override
  set stats(DetailedStatList? value) {
    _$statsAtom.reportWrite(value, super.stats, () {
      super.stats = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_DetailedStatStore.success', context: context);

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

  late final _$getStatsAsyncAction =
      AsyncAction('_DetailedStatStore.getStats', context: context);

  @override
  Future<dynamic> getStats() {
    return _$getStatsAsyncAction.run(() => super.getStats());
  }

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
stats: ${stats},
success: ${success},
loading: ${loading}
    ''';
  }
}
