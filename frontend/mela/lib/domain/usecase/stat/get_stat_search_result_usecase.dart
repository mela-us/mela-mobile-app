import 'dart:async';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/stat/progress_list.dart';
import '../../repository/stat/stat_search_repository.dart';

class GetStatSearchResultUseCase extends UseCase<ProgressList, String> {
  final StatSearchRepository _searchRepository;
  GetStatSearchResultUseCase(this._searchRepository);

  @override
  Future<ProgressList> call({required String params}) {
    return _searchRepository.getStatSearchResult(params);
  }
}