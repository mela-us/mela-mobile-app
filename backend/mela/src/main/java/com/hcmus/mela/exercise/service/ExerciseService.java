package com.hcmus.mela.exercise.service;
import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.exercise.model.Exercise;

import java.util.List;

public interface ExerciseService {
    Exercise findByExerciseId(Integer exerciseId);

    List<Exercise> findAllExercisesInLecture(Integer lectureId);

    ExerciseResponse getExercise(ExerciseRequest exerciseRequest);

    ExerciseResponse getAllExercisesInLecture(ExerciseRequest exerciseRequest);
}
