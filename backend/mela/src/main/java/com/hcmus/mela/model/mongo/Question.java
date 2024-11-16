package com.hcmus.mela.model.mongo;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "exercises")
public class Question {
    @Field("question_id")
    @Indexed(unique = true)
    private Integer questionId;

    @Field("exercise_id")
    private Integer exerciseId;
    @Field("question_content")
    private String questionContent;
    @Field("question_number")
    private Integer questionNumber;
    @Field("answer_content")
    private String answerContent;
    @Field("question_type")
    @Enumerated(EnumType.STRING)
    private QuestionType questionType;
}
