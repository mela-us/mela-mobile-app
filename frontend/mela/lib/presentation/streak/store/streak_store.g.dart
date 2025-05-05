// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StreakStore on _StreakStore, Store {
  Computed<bool>? _$streakLoadingComputed;

  @override
  bool get streakLoading =>
      (_$streakLoadingComputed ??= Computed<bool>(() => super.streakLoading,
              name: '_StreakStore.streakLoading'))
          .value;

  late final _$fetchFutureAtom =
      Atom(name: '_StreakStore.fetchFuture', context: context);

  @override
  ObservableFuture<Streak?> get fetchFuture {
    _$fetchFutureAtom.reportRead();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<Streak?> value) {
    _$fetchFutureAtom.reportWrite(value, super.fetchFuture, () {
      super.fetchFuture = value;
    });
  }

  late final _$updateFutureAtom =
      Atom(name: '_StreakStore.updateFuture', context: context);

  @override
  ObservableFuture<bool?> get updateFuture {
    _$updateFutureAtom.reportRead();
    return super.updateFuture;
  }

  @override
  set updateFuture(ObservableFuture<bool?> value) {
    _$updateFutureAtom.reportWrite(value, super.updateFuture, () {
      super.updateFuture = value;
    });
  }

  late final _$streakAtom = Atom(name: '_StreakStore.streak', context: context);

  @override
  Streak? get streak {
    _$streakAtom.reportRead();
    return super.streak;
  }

  @override
  set streak(Streak? value) {
    _$streakAtom.reportWrite(value, super.streak, () {
      super.streak = value;
    });
  }

  late final _$updateSuccessAtom =
      Atom(name: '_StreakStore.updateSuccess', context: context);

  @override
  bool? get updateSuccess {
    _$updateSuccessAtom.reportRead();
    return super.updateSuccess;
  }

  @override
  set updateSuccess(bool? value) {
    _$updateSuccessAtom.reportWrite(value, super.updateSuccess, () {
      super.updateSuccess = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_StreakStore.isLoading', context: context);

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

  late final _$getStreakAsyncAction =
      AsyncAction('_StreakStore.getStreak', context: context);

  @override
  Future<dynamic> getStreak() {
    return _$getStreakAsyncAction.run(() => super.getStreak());
  }

  late final _$updateStreakAsyncAction =
      AsyncAction('_StreakStore.updateStreak', context: context);

  @override
  Future<dynamic> updateStreak() {
    return _$updateStreakAsyncAction.run(() => super.updateStreak());
  }

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
updateFuture: ${updateFuture},
streak: ${streak},
updateSuccess: ${updateSuccess},
isLoading: ${isLoading},
streakLoading: ${streakLoading}
    ''';
  }
}
