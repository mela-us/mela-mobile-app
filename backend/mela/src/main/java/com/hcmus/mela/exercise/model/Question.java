package com.hcmus.mela.exercise.model;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "questions")
public class Question {
    @Id
    @Field(name = "_id")
    private String id;

    @Field(name = "question_id")
    private Integer questionId;

    @Field(name = "exercise_id")
    private Integer exerciseId;

    @Field(name = "question_number")
    private Integer questionNumber;

    @Field(name = "question_type")
    private String questionType;

    @ElementCollection
    @Field(name = "choices")
    private List<String> choices;

    @ElementCollection
    @Field(name = "question")
    private List<String> question;

    @ElementCollection
    @Field(name = "answer")
    private List<String> answer;
}


