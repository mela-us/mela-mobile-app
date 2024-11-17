package com.hcmus.mela.model.mongo;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.Instant;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "user_exercises")
public class UserExercise {
    @Id
    @Field(name = "_id")
    private String id;

    @Field(name = "user_id")
    private Integer userId;

    @Field(name = "exercise_id")
    private Integer exerciseId;

    @Field(name = "right_answers")
    private Integer rightAnswer;

    @Field(name = "status")
    private String status;

    @Field(name = "test_start")
    private Instant testStart;

    @Field(name = "test_end")
    private Instant testEnd;
}
