package com.hcmus.mela.service;
import com.hcmus.mela.dto.request.ExerciseRequest;
import com.hcmus.mela.dto.response.ExerciseResponse;
import com.hcmus.mela.model.mongo.Exercise;

import java.util.List;

public interface ExerciseService {
    Exercise findByExerciseId(Integer exerciseId);

    List<Exercise> findAllExercisesInLecture(Integer lectureId);

    ExerciseResponse getExercise(ExerciseRequest exerciseRequest);

    ExerciseResponse getAllExercisesInLecture(ExerciseRequest exerciseRequest);
}
