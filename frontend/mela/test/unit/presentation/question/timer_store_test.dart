import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Timer])
void main() {
  late TimerStore timerStore;

  setUp(() {
    timerStore = TimerStore();
  });

  group('TimerStore - Success Cases', () {
    test('Should start timer and increase elapsed time', () async {
      // Act
      timerStore.startTimer();
      await Future.delayed(Duration(seconds: 3)); // Simulate 3 seconds passing
      timerStore.stopTimer();

      // Assert
      expect(timerStore.elapsedTime.inSeconds, greaterThanOrEqualTo(2));
    });

    test('Should stop timer without increasing elapsed time', () async {
      // Arrange
      timerStore.startTimer();
      await Future.delayed(Duration(seconds: 2));
      timerStore.stopTimer();
      final elapsedBefore = timerStore.elapsedTime;

      // Act
      await Future.delayed(Duration(seconds: 2));

      // Assert
      expect(timerStore.elapsedTime, equals(elapsedBefore)); // Should remain the same
    });

    test('Should reset timer correctly', () async {
      // Arrange
      timerStore.startTimer();
      await Future.delayed(Duration(seconds: 2));
      timerStore.stopTimer();

      // Act
      timerStore.resetTimer();

      // Assert
      expect(timerStore.elapsedTime, equals(Duration.zero));
    });
  });
}
