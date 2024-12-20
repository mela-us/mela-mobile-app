package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.ExerciseResult;
import com.hcmus.mela.exercise.model.ExerciseResultCount;

import java.util.List;
import java.util.UUID;

public interface CustomExerciseResultRepository {

    ExerciseResult getBestExerciseResult(UUID userId, UUID exerciseId);

    List<ExerciseResultCount> countTotalPassExerciseOfLectures(UUID userId);
}
