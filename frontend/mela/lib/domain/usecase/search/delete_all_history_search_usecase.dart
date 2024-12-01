import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

class DeleteAllHistorySearchUsecase extends UseCase<void, void> {
  final SearchRepository _searchRepository;
  DeleteAllHistorySearchUsecase(this._searchRepository);
  @override
  Future<void> call({void params}) {
    return _searchRepository.deleteAllHistorySearch();
  }
}
