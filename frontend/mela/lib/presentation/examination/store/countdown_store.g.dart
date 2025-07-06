// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countdown_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CountdownStore on _CountdownStore, Store {
  Computed<bool>? _$isCountdownActiveComputed;

  @override
  bool get isCountdownActive => (_$isCountdownActiveComputed ??= Computed<bool>(
          () => super.isCountdownActive,
          name: '_CountdownStore.isCountdownActive'))
      .value;
  Computed<Duration>? _$timeRemainingComputed;

  @override
  Duration get timeRemaining =>
      (_$timeRemainingComputed ??= Computed<Duration>(() => super.timeRemaining,
              name: '_CountdownStore.timeRemaining'))
          .value;

  late final _$remainingTimeAtom =
      Atom(name: '_CountdownStore.remainingTime', context: context);

  @override
  Duration get remainingTime {
    _$remainingTimeAtom.reportRead();
    return super.remainingTime;
  }

  @override
  set remainingTime(Duration value) {
    _$remainingTimeAtom.reportWrite(value, super.remainingTime, () {
      super.remainingTime = value;
    });
  }

  late final _$isRunningAtom =
      Atom(name: '_CountdownStore.isRunning', context: context);

  @override
  bool get isRunning {
    _$isRunningAtom.reportRead();
    return super.isRunning;
  }

  @override
  set isRunning(bool value) {
    _$isRunningAtom.reportWrite(value, super.isRunning, () {
      super.isRunning = value;
    });
  }

  late final _$_CountdownStoreActionController =
      ActionController(name: '_CountdownStore', context: context);

  @override
  void startCountdown(Duration duration) {
    final _$actionInfo = _$_CountdownStoreActionController.startAction(
        name: '_CountdownStore.startCountdown');
    try {
      return super.startCountdown(duration);
    } finally {
      _$_CountdownStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopCountdown() {
    final _$actionInfo = _$_CountdownStoreActionController.startAction(
        name: '_CountdownStore.stopCountdown');
    try {
      return super.stopCountdown();
    } finally {
      _$_CountdownStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetCountdown() {
    final _$actionInfo = _$_CountdownStoreActionController.startAction(
        name: '_CountdownStore.resetCountdown');
    try {
      return super.resetCountdown();
    } finally {
      _$_CountdownStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
remainingTime: ${remainingTime},
isRunning: ${isRunning},
isCountdownActive: ${isCountdownActive},
timeRemaining: ${timeRemaining}
    ''';
  }
}
