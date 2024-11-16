package com.hcmus.mela.model.mongo;


import com.mongodb.internal.connection.Time;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.time.Duration;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercise")
public class UserExercise {
    @Id
    @Field(name = "_id")
    private String id;

    @Field(name = "user_id")
    private int userId;

    @Field(name = "exercise_id")
    private int exerciseId;

    @Field(name = "test_duration")
    private Duration testDuration;

    @Field(name = "test_time")
    private LocalDateTime testTime;

    @Field(name = "status")
    private String status;
}
