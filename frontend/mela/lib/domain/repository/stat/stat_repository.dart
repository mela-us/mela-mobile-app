import '../../entity/stat/detailed_stat_list.dart';
import '../../entity/stat/progress_list.dart';

abstract class StatRepository{
  Future<ProgressList> getProgressList(String level);
  Future<DetailedStatList> getDetailedStat();
}