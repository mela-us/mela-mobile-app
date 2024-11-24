package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.request.QuestionRequest;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.model.Question;

import java.util.List;

public interface QuestionService {
    Question findByQuestionId(Integer questionId);

    List<Question> findAllQuestionsInExercise(Integer exerciseId);

    QuestionResponse getQuestion(QuestionRequest questionRequest);

    QuestionResponse getAllQuestionsInExercise(QuestionRequest questionRequest);

    Integer getNumberOfQuestionsInExercise(Integer exerciseId);
}
