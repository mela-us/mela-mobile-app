package com.hcmus.mela.history.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface ActivityService {

    List<RecentActivityDto> getRecentActivityOfUser(UUID userId, Integer size);
}