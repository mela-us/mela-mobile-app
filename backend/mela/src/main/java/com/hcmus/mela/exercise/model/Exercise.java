package com.hcmus.mela.exercise.model;


import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercises")
public class Exercise {
    @Id
    @Field(name = "_id")
    private String id;

    @Field(name = "exercise_id")
    private Integer exerciseId;

    @Field(name = "lecture_id")
    private Integer lectureId;

    @Field(name = "exercise_name")
    private String exerciseName;

    @Field(name = "exercise_number")
    private Integer exerciseNumber;
}
