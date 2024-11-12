import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

class GetHistorySearchList extends UseCase<List<String>,void>{
  SearchRepository _searchRepository;
  GetHistorySearchList(this._searchRepository);
  @override
  Future<List<String>> call({void params}) {
    return _searchRepository.getHistorySearchList();
  }
}