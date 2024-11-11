import 'package:mela/domain/entity/exercise/exercise_list.dart';
import 'package:mela/domain/repository/exercise/exercise_repository.dart';

import '../../../domain/entity/exercise/exercise.dart';

class ExerciseRepositoryImpl extends ExerciseRepository {
  @override
  Future<ExerciseList> getExercises(int lectureId) async {
    ExerciseList exerciseList = ExerciseList(exercises: []);
    if (DateTime.now().minute % 2 == 0) {
      exerciseList.exercises = [
        Exercise(
          exerciseId: 0,
          lectureId: lectureId,
          exerciseName: "Bài tập 1",
        ),
        Exercise(
          exerciseId: 1,
          lectureId: lectureId,
          exerciseName: "Bài tập 2",
        ),
        Exercise(
          exerciseId: 2,
          lectureId: lectureId,
          exerciseName: "Bài tập 3",
        )
      ];
    }else{
      exerciseList.exercises = [
        Exercise(
          exerciseId: 3,
          lectureId: lectureId,
          exerciseName: "Bài tập 4",
        ),
        Exercise(
          exerciseId: 4,
          lectureId: lectureId,
          exerciseName: "Bài tập 5",
        ),
        Exercise(
          exerciseId: 5,
          lectureId: lectureId,
          exerciseName: "Bài tập 6",
        )
      ];
    }
    await Future.delayed(const Duration(seconds: 3));
    return exerciseList;
  }
}
