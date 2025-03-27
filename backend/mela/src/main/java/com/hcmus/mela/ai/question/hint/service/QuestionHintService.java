package com.hcmus.mela.ai.question.hint.service;

import java.util.List;
import java.util.UUID;

public interface QuestionHintService {

    List<String> generateTerm(UUID questionId);

    List<String> generateGuide(UUID questionId);
}
