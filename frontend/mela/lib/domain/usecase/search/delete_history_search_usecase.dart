import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

class DeleteHistorySearchUsecase extends UseCase<void, HistorySearch> {
  final SearchRepository _searchRepository;
  DeleteHistorySearchUsecase(this._searchRepository);
  @override
  Future<void> call({required HistorySearch params}) {
    return _searchRepository.deleteHistorySearch(params);
  }
}
