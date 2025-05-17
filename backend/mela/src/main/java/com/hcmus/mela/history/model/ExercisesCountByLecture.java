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
public class ExercisesCountByLecture {

    @Id
    private UUID lectureId;

    @Field(name = "total_exercises")
    private Integer totalExercises;
}
