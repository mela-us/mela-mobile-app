package com.hcmus.mela.statistic.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuestionStatsDto {
    private TopicDto topic;
    private LevelDto level;
    private Integer totalCorrectAnswers;
    private Integer totalAnswers;
    private List<DailyQuestionStatsDto> last7Days;
}
