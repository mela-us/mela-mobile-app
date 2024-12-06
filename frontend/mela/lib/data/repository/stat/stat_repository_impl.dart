import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/domain/entity/stat/detailed_progress_list.dart';
//import 'package:mela/domain/entity/stat/progress.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import '../../../constants/global.dart';
import '../../network/apis/stats/stats_api.dart';

class StatRepositoryImpl extends StatRepository{
  StatsApi _statsApi;
  StatRepositoryImpl(this._statsApi);

  @override
  Future<ProgressList> getProgressList() async{
    return _statsApi.getStats();
  }

  @override
  Future<DetailedProgressList> getDetailedProgressList() async{
    return DetailedProgressList(
        detailedProgressList: []
    );
  }
}