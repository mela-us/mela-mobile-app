import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';

import '../../entity/exercise/exercise_list.dart';
import '../../repository/exercise/exercise_repository.dart';

class GetExercisesUseCase extends UseCase<ExerciseList, String> {
  final ExerciseRepository _exerciseRepository;
  GetExercisesUseCase(this._exerciseRepository);

  @override
  Future<ExerciseList> call({required String params}) {
    return _exerciseRepository.getExercises(params);
  }
  
  
}