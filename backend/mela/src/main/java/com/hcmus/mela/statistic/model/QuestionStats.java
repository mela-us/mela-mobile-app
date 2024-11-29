package com.hcmus.mela.statistic.model;

import com.hcmus.mela.statistic.dto.dto.LevelDto;
import com.hcmus.mela.statistic.dto.dto.TopicDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuestionStats {

    private Topic topic;

    private Level level;

    @Field("total_correct_answers")
    private Integer totalCorrectAnswers;

    @Field("total_answers")
    private Integer totalAnswers;
}
