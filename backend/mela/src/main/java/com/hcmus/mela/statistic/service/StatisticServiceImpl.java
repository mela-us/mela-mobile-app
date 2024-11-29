package com.hcmus.mela.statistic.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.statistic.dto.dto.DailyQuestionStatsDto;
import com.hcmus.mela.statistic.dto.dto.QuestionStatsDto;
import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;
import com.hcmus.mela.statistic.mapper.DailyQuestionStatsMapper;
import com.hcmus.mela.statistic.mapper.QuestionStatsMapper;
import com.hcmus.mela.statistic.model.DailyQuestionStats;
import com.hcmus.mela.statistic.model.QuestionStats;
import com.hcmus.mela.statistic.repository.StatisticRepository;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StatisticServiceImpl implements StatisticService {

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final StatisticRepository statisticRepository;

    private final JwtTokenService jwtTokenService;

    @Override
    public GetStatisticsResponse getStatisticByUserId(String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader)
        );

        List<QuestionStats> questionStatsList = statisticRepository.getQuestionStats(userId);
        List<DailyQuestionStats> dailyQuestionStatsList = statisticRepository.getDailyQuestionStatsLast7Days(userId);

        List<QuestionStatsDto> questionStatsDtos = new ArrayList<>();

        for (QuestionStats stats : questionStatsList) {
            QuestionStatsDto questionStatsDto = QuestionStatsMapper.INSTANCE.questionStatsToQuestionStatsDto(stats);
            List<DailyQuestionStatsDto> dailyQuestionStatsDtos = dailyQuestionStatsList.stream()
                    .filter(dailyStats ->
                            dailyStats.getTopicId().equals(stats.getTopic().getTopicId())
                                    && dailyStats.getLevelId().equals(stats.getLevel().getLevelId())
                    )
                    .map(DailyQuestionStatsMapper.INSTANCE::dailyQuestionStatsToDailyQuestionStatsDto)
                    .collect(Collectors.toList());
            questionStatsDto.setLast7Days(dailyQuestionStatsDtos);
            questionStatsDtos.add(questionStatsDto);
        }

        return new GetStatisticsResponse(
                generalMessageAccessor.getMessage(null, "get_statistic_success"),
                questionStatsDtos
        );
    }
}