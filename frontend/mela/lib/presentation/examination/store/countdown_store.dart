import 'dart:async';

import 'package:mobx/mobx.dart';

part 'countdown_store.g.dart';

class CountdownStore = _CountdownStore with _$CountdownStore;

abstract class _CountdownStore with Store {
  // Observable properties
  @observable
  Duration remainingTime = Duration.zero;

  @observable
  bool isRunning = false;

  // Timer instance
  Timer? _timer;

  // Start the countdown timer
  @action
  void startCountdown(Duration duration) {
    remainingTime = duration;
    isRunning = true;

    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (remainingTime.inSeconds > 0) {
        remainingTime -= Duration(seconds: 1);
      } else {
        stopCountdown();
      }
    });
  }

  // Stop the countdown timer
  @action
  void stopCountdown() {
    _timer?.cancel();
    isRunning = false;
    remainingTime = Duration.zero;
  }

  // Reset the countdown timer
  @action
  void resetCountdown() {
    stopCountdown();
    remainingTime = Duration.zero;
  }

  @computed
  bool get isCountdownActive => isRunning && remainingTime.inSeconds > 0;

  @computed
  Duration get timeRemaining => remainingTime;
}
