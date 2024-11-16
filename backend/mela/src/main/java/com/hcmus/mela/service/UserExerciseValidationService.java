package com.hcmus.mela.service;

import com.hcmus.mela.dto.request.ExerciseRequest;
import com.hcmus.mela.exceptions.custom.ExerciseException;
import com.hcmus.mela.repository.mongo.ExerciseRepository;
import com.hcmus.mela.repository.mongo.UserExerciseRepository;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExerciseValidationService {
    private static final String USER_NOT_STUDY = "user_not_study_exercise";

    private final UserExerciseRepository userExerciseRepository;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    public void validateUserExercise(Integer userId, Integer exerciseId) {
        checkUserIdAndExerciseId(userId, exerciseId);
    }

    private void checkUserIdAndExerciseId(Integer userId, Integer exerciseId) {
        final boolean existsByUserIdAndExerciseId = userExerciseRepository.existsByUserIdAndExerciseId(userId, exerciseId);
        if (!existsByUserIdAndExerciseId) {
            log.warn("User ID {userId} hasn't studied exercise ID {exerciseId}");

            final String notStudiesUserId = exceptionMessageAccessor.getMessage(null, USER_NOT_STUDY);
            throw new ExerciseException(notStudiesUserId);
        }
    }
}
