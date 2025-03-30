package com.hcmus.mela.ai.question.hint.service;

import com.hcmus.mela.ai.question.hint.dto.response.HintResponseDto;
import java.util.UUID;

public interface QuestionHintService {

    HintResponseDto generateTerms(UUID questionId);

    HintResponseDto generateGuide(UUID questionId);
}
