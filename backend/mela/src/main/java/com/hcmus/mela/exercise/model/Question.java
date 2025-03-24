package com.hcmus.mela.exercise.model;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.DocumentReference;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document
public class Question {
    @Field(name = "_id")
    private UUID questionId;

    @Field(name = "ordinal_number")
    private Integer ordinalNumber;

    @Field(name = "content")
    private String content;

    @Field(name = "question_type")
    private QuestionType questionType;

    @Field(name = "options")
    private List<Option> options;

    @Field(name = "blank_answer")
    private String blankAnswer;

    @Field(name = "term")
    private String term;

    @Field(name = "guide")
    private String guide;
}


