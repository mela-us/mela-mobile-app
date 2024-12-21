package com.hcmus.mela.statistic.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercise_results")
public class QuestionStats {

    private Topic topic;

    private Level level;

    @Field("total_correct_answers")
    private Integer totalCorrectAnswers;

    @Field("total_answers")
    private Integer totalAnswers;
}
