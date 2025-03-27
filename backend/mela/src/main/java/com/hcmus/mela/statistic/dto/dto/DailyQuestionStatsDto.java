package com.hcmus.mela.statistic.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DailyQuestionStatsDto {

    private Integer totalCorrectAnswers;

    private Integer totalAnswers;

    private String date;
}
