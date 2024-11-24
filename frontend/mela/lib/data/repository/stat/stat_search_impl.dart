import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/presentation/stats/store/stats_store.dart';

import '../../../constants/global.dart';
import '../../../di/service_locator.dart';
import '../../../domain/entity/stat/progress.dart';
import '../../../domain/repository/stat/stat_search_repository.dart';


class StatSearchRepositoryImpl extends StatSearchRepository {
  @override
  Future<List<String>> getStatSearchHistory() async {
    List<String> historySearchList = ['Số học', 'Hình học', 'Hello'];
    return historySearchList;
  }

  @override
  Future<ProgressList> getStatSearchResult(String searchText) async {
    List<Progress>? temp = Global.progressList?.where(
            (progress) => progress.topicName?.contains(searchText) ?? false
    ).toList();
    return ProgressList(
        progressList: temp,
    );
  }
}
