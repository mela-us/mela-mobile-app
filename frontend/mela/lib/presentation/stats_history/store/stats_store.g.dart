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

  late final _$fetchLevelsFutureAtom =
      Atom(name: '_StatisticsStore.fetchLevelsFuture', context: context);

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

  late final _$levelListAtom =
      Atom(name: '_StatisticsStore.levelList', context: context);

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

  late final _$levelLoadingAtom =
      Atom(name: '_StatisticsStore.levelLoading', context: context);

  @override
  bool get levelLoading {
    _$levelLoadingAtom.reportRead();
    return super.levelLoading;
  }

  @override
  set levelLoading(bool value) {
    _$levelLoadingAtom.reportWrite(value, super.levelLoading, () {
      super.levelLoading = value;
    });
  }

  late final _$getProgressListAsyncAction =
      AsyncAction('_StatisticsStore.getProgressList', context: context);

  @override
  Future<dynamic> getProgressList(String level) {
    return _$getProgressListAsyncAction.run(() => super.getProgressList(level));
  }

  late final _$getLevelsAsyncAction =
      AsyncAction('_StatisticsStore.getLevels', context: context);

  @override
  Future<dynamic> getLevels() {
    return _$getLevelsAsyncAction.run(() => super.getLevels());
  }

  @override
  String toString() {
    return '''
fetchProgressFuture: ${fetchProgressFuture},
fetchLevelsFuture: ${fetchLevelsFuture},
progressList: ${progressList},
levelList: ${levelList},
success: ${success},
levelLoading: ${levelLoading},
progressLoading: ${progressLoading}
    ''';
  }
}
