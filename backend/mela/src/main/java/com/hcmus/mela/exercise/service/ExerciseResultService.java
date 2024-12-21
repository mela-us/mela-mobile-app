package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.dto.request.ExerciseResultRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResultResponse;
import com.hcmus.mela.exercise.model.ExerciseResult;
import com.hcmus.mela.exercise.model.ExerciseResultCount;

import java.util.List;
import java.util.UUID;

public interface ExerciseResultService {

    List<ExerciseResult> findAllByUserIdAndExerciseId(UUID userId, UUID exerciseId);

    ExerciseResultDto getBestExerciseResult(UUID userId, UUID exerciseId);

    ExerciseResultResponse saveResult(ExerciseResultRequest exerciseResultRequest, UUID userId);

    List<ExerciseResultCount> countTotalPassExerciseOfLectures(UUID userId);
}
