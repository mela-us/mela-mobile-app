package com.hcmus.mela.service;

import com.hcmus.mela.dto.request.QuestionRequest;
import com.hcmus.mela.dto.response.QuestionResponse;
import com.hcmus.mela.model.mongo.Question;

import java.util.List;

public interface QuestionService {
    Question findByQuestionId(Integer questionId);

    List<Question> findAllQuestionsInExercise(Integer exerciseId);

    QuestionResponse getQuestion(QuestionRequest questionRequest);

    QuestionResponse getAllQuestionsInExercise(QuestionRequest questionRequest);
}
