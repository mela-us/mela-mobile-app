package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.model.Question;

import java.util.UUID;

public interface QuestionService {

    Question findByQuestionId(UUID questionId);
}
