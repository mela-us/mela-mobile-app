package com.hcmus.mela.statistic.service;

import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;

public interface StatisticService {

    GetStatisticsResponse getStatisticByUserId(String authorizationHeader);
}