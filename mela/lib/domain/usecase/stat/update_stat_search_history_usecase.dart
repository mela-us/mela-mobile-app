import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/stat/stat_search_repository.dart';

class UpdateStatSearchHistoryUseCase extends UseCase<void,List<String>>{
  StatSearchRepository _statSearchRepository;
  UpdateStatSearchHistoryUseCase(this._statSearchRepository);

  @override
  Future<void> call({required List<String> params}) {
    return _statSearchRepository.updateStatSearchHistory(params);
  }
}