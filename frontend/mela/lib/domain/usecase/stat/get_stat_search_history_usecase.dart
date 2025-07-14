import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/stat/stat_search_repository.dart';

class GetStatSearchHistoryUseCase extends UseCase<List<String>,void>{
  StatSearchRepository _statSearchRepository;
  GetStatSearchHistoryUseCase(this._statSearchRepository);

  @override
  Future<List<String>> call({void params}) {
    return _statSearchRepository.getStatSearchHistory();
  }
}