import 'package:mela/data/local/datasources/history_search/history_search_datasource.dart';
import 'package:mela/data/network/apis/searchs/search_api.dart';
import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

import '../../../domain/entity/lecture/lecture.dart';

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
    // TODO: implement addHistorySearch
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteAllHistorySearch() {
    // TODO: implement deleteAllHistorySearch
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteHistorySearch(HistorySearch historySearch) {
    // TODO: implement deleteHistorySearch
    throw UnimplementedError();
  }
}
