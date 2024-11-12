import 'package:mela/domain/entity/lecture/lecture_list.dart';

abstract class SearchRepository {
  Future<List<String>> getHistorySearchList();
  Future<LectureList> getSearchLecturesResult(String searchText);
}