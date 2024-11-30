import 'package:mela/data/network/apis/searchs/search_api.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

import '../../../domain/entity/lecture/lecture.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchApi _searchApi;
  SearchRepositoryImpl(this._searchApi);
  @override
  Future<List<String>> getHistorySearchList() async {
    List<String> historySearchList = [
      'Lich su 1 Lich su 4 Lich su 4 Lich su 4 Lich su 4 Lich su 4 Lich su 4 ',
      'Lich su 2',
      'Lich su 3'
    ];
    await Future.delayed(const Duration(seconds: 2));
    return historySearchList;
  }

  @override
  Future<LectureList> getSearchLecturesResult(String searchText) async {
    return _searchApi.searchLecturesByText(searchText);
  }
}
