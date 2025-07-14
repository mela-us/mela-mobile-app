import 'dart:async';

import 'package:mobx/mobx.dart';
part 'timer_store.g.dart';

class TimerStore = _TimerStore with _$TimerStore;

abstract class _TimerStore with Store{
  final Duration _TimeStep = const Duration(seconds: 1);
  @observable
  Duration _elapsedTime = Duration.zero;

  @observable
  Timer? _timer;

  //Start timer
  @action
  void startTimer(){
    _timer = Timer.periodic(_TimeStep, (_){
      _elapsedTime += _TimeStep;
    });
  }

  //Stop timer
  @action
  void stopTimer(){
    _timer?.cancel();
  }

  //Reset timer
  @action
  void resetTimer(){
    stopTimer();
    _elapsedTime = Duration.zero;
  }

  //Compute elapsed time
  @computed
  Duration get elapsedTime => _elapsedTime;
}