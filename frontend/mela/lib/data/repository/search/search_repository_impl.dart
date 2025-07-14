import 'package:mela/data/local/datasources/history_search/history_search_datasource.dart';
import 'package:mela/data/network/apis/searchs/search_api.dart';
import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/repository/search/search_repository.dart';


class SearchRepositoryImpl extends SearchRepository {
  SearchApi _searchApi;
  HistoryDataSource _historyDataSource;
  SearchRepositoryImpl(this._searchApi, this._historyDataSource);
  @override
  Future<List<HistorySearch>> getHistorySearchList() {
    return _historyDataSource.getAllHistory();
  }

  @override
  Future<LectureList> getSearchLecturesResult(String searchText) {
    return _searchApi.searchLecturesByText(searchText);
  }

  @override
  Future<void> addHistorySearch(HistorySearch historySearch) {
    print("=============AddHistorySearch_IMPL");
    return _historyDataSource.insert(historySearch);
  }

  @override
  Future<void> deleteAllHistorySearch() {
    return _historyDataSource.deleteAll();
  }

  @override
  Future<void> deleteHistorySearch(HistorySearch historySearch) {
    return _historyDataSource.delete(historySearch);
  }
}
