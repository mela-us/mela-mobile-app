package com.hcmus.mela.model.mongo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercises")
public class Exercise {
    @Field("exercise_id")
    @Indexed(unique = true)
    private Integer exerciseId;

    @Field("lecture_id")
    private Integer lectureId;
    @Field("exercise_name")
    private String exerciseName;
    @Field("exercise_number")
    private int exerciseNumber;
    @Field("questions_count")
    private Integer questionsCount;
}
