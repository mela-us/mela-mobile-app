package com.hcmus.mela.statistic.service;

import com.hcmus.mela.statistic.dto.dto.ActivityType;
import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;

import java.util.UUID;

public interface StatisticService {

    GetStatisticsResponse getStatisticByUserAndLevelAndType(UUID userId, UUID levelId, ActivityType activityType);
}