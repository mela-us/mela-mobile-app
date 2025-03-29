import '../../entity/stat/progress_list.dart';

abstract class StatRepository{
  Future<ProgressList> getProgressList(String level);
}