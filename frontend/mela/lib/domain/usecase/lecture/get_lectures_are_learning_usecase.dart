import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';

class GetLecturesAreLearningUsecase extends UseCase<LectureList, void> {
  LectureRepository _lectureRepository;
  GetLecturesAreLearningUsecase(this._lectureRepository);
  @override
  Future<LectureList> call({void params}) {
    return _lectureRepository.getLecturesAreLearning();
  }
}