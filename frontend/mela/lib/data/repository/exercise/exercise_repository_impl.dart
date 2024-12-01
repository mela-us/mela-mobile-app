import 'package:mela/data/network/apis/exercises/exercise_api.dart';
import 'package:mela/domain/entity/exercise/exercise_list.dart';
import 'package:mela/domain/repository/exercise/exercise_repository.dart';

import '../../../domain/entity/exercise/exercise.dart';

class ExerciseRepositoryImpl extends ExerciseRepository {
  final ExerciseApi _exerciseApi;
  ExerciseRepositoryImpl(this._exerciseApi);
  @override
  Future<ExerciseList> getExercises(String lectureId) async {
    // ExerciseList exerciseList = ExerciseList(exercises: []);
    // await Future.delayed(const Duration(seconds: 3));
    // //throw "Error in exercise repository";
    // return exerciseList;
    return _exerciseApi.getExercises(lectureId);
  }
}
