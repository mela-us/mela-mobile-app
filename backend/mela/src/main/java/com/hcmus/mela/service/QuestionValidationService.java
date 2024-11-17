package com.hcmus.mela.service;

import com.hcmus.mela.dto.request.QuestionRequest;
import com.hcmus.mela.exceptions.custom.ExerciseException;
import com.hcmus.mela.repository.mongo.QuestionRepository;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionValidationService {

    private static final String QUESTION_NOT_EXISTS = "question_id_must_exist";

    private static final String EXERCISE_NOT_EXISTS = "exercise_id_must_exist";

    private final QuestionRepository questionRepository;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    public void validateQuestion(QuestionRequest questionRequest) {
        final Integer questionId = questionRequest.getQuestionId();
        checkQuestionId(questionId);
    }

    public void validateExercise(QuestionRequest questionRequest) {
        final Integer exerciseId = questionRequest.getExerciseId();
        checkExerciseId(exerciseId);
    }

    private void checkQuestionId(Integer questionId) {
        final boolean existsByQuestionId = questionRepository.existsByQuestionId(questionId);
        if (!existsByQuestionId) {
            log.warn("Question ID {} doesn't exist", questionId);

            final String notExistsQuestionId = exceptionMessageAccessor.getMessage(null, QUESTION_NOT_EXISTS);
            throw new ExerciseException(notExistsQuestionId);
        }
    }

    private void checkExerciseId(Integer exerciseId) {
        final boolean existsByExerciseId = questionRepository.existsByExerciseId(exerciseId);
        if (!existsByExerciseId) {
            log.warn("exercise ID {} doesn't exist", exerciseId);

            final String notExistsExerciseId = exceptionMessageAccessor.getMessage(null, EXERCISE_NOT_EXISTS);
            throw new ExerciseException(notExistsExerciseId);
        }
    }
}
