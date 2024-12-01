import '../../entity/stat/progress_list.dart';
import '../../entity/stat/detailed_progress_list.dart';

abstract class StatRepository{
  Future<ProgressList> getProgressList();
  Future<DetailedProgressList> getDetailedProgressList();
}