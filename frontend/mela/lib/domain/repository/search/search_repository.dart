import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';

abstract class SearchRepository {
  Future<List<HistorySearch>> getHistorySearchList();
  Future<void> addHistorySearch(HistorySearch historySearch);
  Future<void> deleteHistorySearch(HistorySearch historySearch);
  Future<void> deleteAllHistorySearch();
  Future<LectureList> getSearchLecturesResult(String searchText);
}