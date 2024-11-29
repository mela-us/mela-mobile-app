import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetDividedLectureUsecase extends UseCase<DividedLectureList,String>{
    LectureRepository _lectureRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  GetDividedLectureUsecase(this._lectureRepository, this._refreshAccessTokenUsecase);

  @override
  Future<DividedLectureList> call({required String params}) {
    return _lectureRepository.getDividedLectureList(params);
  }
}