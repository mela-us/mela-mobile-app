package com.hcmus.mela.statistic.dto.dto;

import com.hcmus.mela.lecture.model.Topic;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

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
