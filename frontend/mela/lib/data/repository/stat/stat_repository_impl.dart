import 'package:mela/domain/entity/stat/detailed_stat_list.dart';
import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import '../../network/apis/stats/stats_api.dart';

class StatRepositoryImpl extends StatRepository{
  final StatsApi _statsApi;
  StatRepositoryImpl(this._statsApi);

  @override
  Future<ProgressList> getProgressList(String level) async{
    return _statsApi.getProgress(level);
  }

  @override
  Future<DetailedStatList> getDetailedStat() {
    return _statsApi.getDetailedStat();
  }
}