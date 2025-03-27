package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.exception.ExerciseException;
import com.hcmus.mela.exercise.repository.QuestionRepository;
import com.hcmus.mela.common.utils.ExceptionMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionValidationService {

    private static final String QUESTION_NOT_EXISTS = "question_id_must_exist";

    private final QuestionRepository questionRepository;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    public void validateQuestion(UUID questionId) {
        checkQuestionId(questionId);
    }

    private void checkQuestionId(UUID questionId) {
        final boolean existsByQuestionId = questionRepository.existsByQuestionId(questionId);
        if (!existsByQuestionId) {
            log.warn("Question ID {} doesn't exist", questionId);

            final String notExistsQuestionId = exceptionMessageAccessor.getMessage(null, QUESTION_NOT_EXISTS);
            throw new ExerciseException(notExistsQuestionId);
        }
    }
}
