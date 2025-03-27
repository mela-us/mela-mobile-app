package com.hcmus.mela.ai.question.hint.service;

public interface QuestionHintService {

    String generateTermTask(String level);

    String generateTermData(String question, String answer);

    String generateTermBackground(String level);

    String generateTermRequirement(String level);

    String generateTerm(String level, String answer, String question);

    String generateGuideTask(String level);

    String generateGuideData(String question, String answer);

    String generateGuideBackground(String level);

    String generateGuideRequirement(String level);

    String generateGuide(String level, String answer, String question);
}
