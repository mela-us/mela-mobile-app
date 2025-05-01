package com.hcmus.mela.exercise.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercise_results")
public class ExerciseResult {

    @Id
    @Field(name = "_id")
    private UUID exerciseResultId;

    @Field(name = "user_id")
    private UUID userId;

    @Field(name = "topic_id")
    private UUID topicId;

    @Field(name = "lecture_id")
    private UUID lectureId;

    @Field(name = "level_id")
    private UUID levelId;

    @Field(name = "exercise_id")
    private UUID exerciseId;

    @Field(name = "start_at")
    private Date startAt;

    @Field(name = "end_at")
    private Date endAt;

    @Field(name = "total_correct_answers")
    private Integer totalCorrectAnswers;

    @Field(name = "total_answers")
    private Integer totalAnswers;

    @Field(name = "status")
    private ExerciseStatus status;
}
