package com.hcmus.mela.history.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Document(collection = "exercise_histories")
public class ExerciseHistory {

    @Id
    @Field(name = "_id")
    private UUID id;

    @Field("lecture_id")
    private UUID lectureId;

    @Field("user_id")
    private UUID userId;

    @Field("exercise_id")
    private UUID exerciseId;

    @Field("level_id")
    private UUID levelId;

    @Field("topic_id")
    private UUID topicId;

    @Field("score")
    private Double score;

    @Field("started_at")
    private LocalDateTime startedAt;

    @Field("completed_at")
    private LocalDateTime completedAt;

    @Field("answers")
    private List<ExerciseAnswer> answers;
}