package com.hcmus.mela.statistic.service;

import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;

public interface StatisticService {
    public GetStatisticsResponse getStatisticByUserId(String authorizationHeader);

}