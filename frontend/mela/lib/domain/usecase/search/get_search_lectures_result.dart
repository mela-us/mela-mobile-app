import 'dart:async';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/lecture/lecture_list.dart';
import '../../repository/search/search_repository.dart';

class GetSearchLecturesResult extends UseCase<LectureList, String> {
  final SearchRepository _searchRepository;
  GetSearchLecturesResult(this._searchRepository);

  @override
  Future<LectureList> call({required String params}) {
    return _searchRepository.getSearchLecturesResult(params);
  }
}