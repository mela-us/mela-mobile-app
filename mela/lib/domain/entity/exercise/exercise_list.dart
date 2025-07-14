import 'package:mela/domain/entity/exercise/exercise.dart';

class ExerciseList {
  List<Exercise> exercises;
  ExerciseList({required this.exercises});
  factory ExerciseList.fromJson(List<dynamic> json) {
    List<Exercise> exercises = [];
    json.forEach((exercise) {
      exercises.add(Exercise.fromJson(exercise));
    });
    return ExerciseList(exercises: exercises);
  }
}