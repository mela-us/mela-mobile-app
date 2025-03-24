package com.hcmus.mela.ai.question.hint.service;

public interface QuestionHintService {
    String generateTerm(String level, String question, String answer);

    String generateGuide(String level, String question, String answer);
}
