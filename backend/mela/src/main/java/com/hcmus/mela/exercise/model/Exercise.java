package com.hcmus.mela.exercise.model;

import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercises")
public class Exercise {
    @Id
    @Field(name = "_id")
    private UUID exerciseId;

    @Field(name = "lecture_id")
    private UUID lectureId;

    @Field(name = "name")
    private String exerciseName;

    @Field(name = "ordinal_number")
    private Integer ordinalNumber;

    @Field(name = "questions")
    private List<Question> questions;
}
