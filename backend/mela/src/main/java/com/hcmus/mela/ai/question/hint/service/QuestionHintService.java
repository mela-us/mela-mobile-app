package com.hcmus.mela.ai.question.hint.service;

import java.util.List;
import java.util.UUID;

public interface QuestionHintService {

    List<String> generateTerm(UUID questionId, UUID exerciseId);

    List<String> generateGuide(UUID questionId, UUID exerciseId);
}
