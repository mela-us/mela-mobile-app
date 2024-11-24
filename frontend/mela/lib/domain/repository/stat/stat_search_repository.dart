import 'package:mela/domain/entity/stat/progress_list.dart';

import '../../entity/stat/progress.dart';

abstract class StatSearchRepository {
  Future<List<String>> getStatSearchHistory();
  Future<ProgressList> getStatSearchResult(String searchText);
}