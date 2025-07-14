import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

class GetHistorySearchListUsecase extends UseCase<List<HistorySearch>,void>{
  SearchRepository _searchRepository;
  GetHistorySearchListUsecase(this._searchRepository);
  @override
  Future<List<HistorySearch>> call({void params}) {
    return _searchRepository.getHistorySearchList();
  }
}