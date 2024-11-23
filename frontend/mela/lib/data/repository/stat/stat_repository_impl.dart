import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/domain/entity/stat/detailed_progress_list.dart';
//import 'package:mela/domain/entity/stat/progress.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import '../../../constants/global.dart';

class StatRepositoryImpl extends StatRepository{

  @override
  Future<ProgressList> getProgressList() async{
    return ProgressList(
        progressList: Global.progressList
    );
  }

  @override
  Future<DetailedProgressList> getDetailedProgressList() async{
    return DetailedProgressList(
        detailedProgressList: Global.detailedProgressList
    );
  }

  @override
  Future<ProgressList> updateProgressList(ProgressList newProgressList) {
    // TODO: implement updateQuestions
    throw UnimplementedError();
  }

}