import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';

import '../../entity/level/level_list.dart';

class GetLevelsUsecase extends UseCase<LevelList, void> {
  final LectureRepository _lectureRepository;
  GetLevelsUsecase(this._lectureRepository);
  @override
  Future<LevelList> call({required void params}) {
    //it not use accessToken so do not need to refresh accessToken
    return _lectureRepository.getLevels();
  }
}
