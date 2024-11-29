package com.hcmus.mela.statistic.repository;

import com.hcmus.mela.statistic.model.DailyQuestionStats;
import com.hcmus.mela.statistic.model.QuestionStats;

import java.util.List;
import java.util.UUID;

public interface StatisticRepository {

    List<QuestionStats> getQuestionStats(UUID userId);

    List<DailyQuestionStats> getDailyQuestionStatsLast7Days(UUID userId);
}

