package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.request.QuestionRequest;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;
import com.hcmus.mela.exercise.model.Question;

import java.util.List;
import java.util.UUID;

public interface QuestionService {
    Question findByQuestionId(UUID questionId);

    String generateTerm(String level, String question, String answer);

    String generateGuide(String level, String question, String answer);
}
