import 'package:mela/domain/entity/exercise/exercise_list.dart';

abstract class ExerciseRepository {
  Future<ExerciseList> getExercises(int lectureId);
  //update exercise,....
}