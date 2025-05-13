import 'dart:async';

import 'package:mela/domain/entity/streak/streak.dart';

abstract class StreakRepository {
  Future<Streak> getStreak();
  Future<bool> updateStreak();
}
