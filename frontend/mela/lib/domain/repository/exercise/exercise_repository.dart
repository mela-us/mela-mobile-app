import 'package:mela/domain/entity/exercise/exercise_list.dart';

abstract class ExerciseRepository {
  Future<ExerciseList> getExercises(String lectureId);
  //update exercise,....
}