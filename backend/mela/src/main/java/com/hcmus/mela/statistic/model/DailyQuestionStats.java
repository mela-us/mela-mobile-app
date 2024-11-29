package com.hcmus.mela.statistic.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDate;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "lecture_content")
public class DailyQuestionStats {
    @Field("total_correct_answers")
    private Integer totalCorrectAnswers;

    @Field("total_answers")
    private Integer totalAnswers;

    private LocalDate date;

    @Field("topic_id")
    private UUID topicId;

    @Field("level_id")
    private UUID levelId;
}
