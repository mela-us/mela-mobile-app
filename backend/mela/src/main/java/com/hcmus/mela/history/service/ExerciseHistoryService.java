package com.hcmus.mela.history.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface ExerciseHistoryService {

    ExerciseResultResponse getExerciseResultResponse(String authorizationHeader, ExerciseResultRequest exerciseResultRequest);

    Map<UUID, Integer> getPassedExerciseCountForLecturesOfUser(List<UUID> lectureIdList, UUID userId);

    List<RecentActivityDto> getRecentActivity(UUID userId);

    Map<UUID, ExerciseResultDto> getExerciseBestResultOfUser(List<UUID> exerciseIdList, UUID userId);

    List<ExerciseHistoryDto> getExerciseHistoryByUserAndLevel(UUID userId, UUID levelId);
}