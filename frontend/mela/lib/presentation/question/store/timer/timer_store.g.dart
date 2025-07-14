// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimerStore on _TimerStore, Store {
  Computed<Duration>? _$elapsedTimeComputed;

  @override
  Duration get elapsedTime =>
      (_$elapsedTimeComputed ??= Computed<Duration>(() => super.elapsedTime,
              name: '_TimerStore.elapsedTime'))
          .value;

  late final _$_elapsedTimeAtom =
      Atom(name: '_TimerStore._elapsedTime', context: context);

  @override
  Duration get _elapsedTime {
    _$_elapsedTimeAtom.reportRead();
    return super._elapsedTime;
  }

  @override
  set _elapsedTime(Duration value) {
    _$_elapsedTimeAtom.reportWrite(value, super._elapsedTime, () {
      super._elapsedTime = value;
    });
  }

  late final _$_timerAtom = Atom(name: '_TimerStore._timer', context: context);

  @override
  Timer? get _timer {
    _$_timerAtom.reportRead();
    return super._timer;
  }

  @override
  set _timer(Timer? value) {
    _$_timerAtom.reportWrite(value, super._timer, () {
      super._timer = value;
    });
  }

  late final _$_TimerStoreActionController =
      ActionController(name: '_TimerStore', context: context);

  @override
  void startTimer() {
    final _$actionInfo = _$_TimerStoreActionController.startAction(
        name: '_TimerStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_TimerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTimer() {
    final _$actionInfo = _$_TimerStoreActionController.startAction(
        name: '_TimerStore.stopTimer');
    try {
      return super.stopTimer();
    } finally {
      _$_TimerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetTimer() {
    final _$actionInfo = _$_TimerStoreActionController.startAction(
        name: '_TimerStore.resetTimer');
    try {
      return super.resetTimer();
    } finally {
      _$_TimerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
elapsedTime: ${elapsedTime}
    ''';
  }
}
