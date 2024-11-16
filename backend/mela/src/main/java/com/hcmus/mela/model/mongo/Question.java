package com.hcmus.mela.model.mongo;

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

    @Field(name = "question_content")
    private QuestionContent questionContent;

    @Field(name = "question_number")
    private Integer questionNumber;

    @Field(name = "answer_content")
    private AnswerContent answerContent;

    @Field(name = "question_type")
    private String questionType;
}

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
class QuestionContent {

    @Field(name = "question")
    private List<String> question;

    @Field(name = "choices")
    private List<String> choices;
}
