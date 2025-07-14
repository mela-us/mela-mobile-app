import '../../../domain/entity/streak/streak.dart';
import '../../../domain/repository/streak/streak_repository.dart';
import '../../network/apis/streak/streak_api.dart';

class StreakRepositoryImpl extends StreakRepository{
  final StreakApi _api;

  StreakRepositoryImpl(this._api);

  @override
  Future<Streak> getStreak() async{
    return _api.getStreak();
  }

  @override
  Future<bool> updateStreak() async{
    return _api.updateStreak();
  }
}
