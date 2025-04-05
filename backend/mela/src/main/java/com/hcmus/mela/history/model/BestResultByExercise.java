package com.hcmus.mela.history.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BestResultByExercise {

    @Id
    @Field(name = "exercise_id")
    private UUID exerciseId;

    @Field("score")
    private Double score;
}
