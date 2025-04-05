package com.hcmus.mela.history.service;

import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface ExerciseHistoryService {

    ExerciseResultResponse getExerciseResultResponse(UUID userId, ExerciseResultRequest exerciseResultRequest);

    Map<UUID, Integer> getPassedExerciseCountOfUser(UUID userId);

    Map<UUID, Double> getExerciseBestScoresOfUserByLecture(UUID userId, UUID lectureId);

    List<ExerciseHistoryDto> getExerciseHistoryByUserAndLevel(UUID userId, UUID levelId);
}