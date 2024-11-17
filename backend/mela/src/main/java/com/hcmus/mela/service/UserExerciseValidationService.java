package com.hcmus.mela.service;

import com.hcmus.mela.repository.mongo.UserExerciseRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExerciseValidationService {

    private final UserExerciseRepository userExerciseRepository;

    public boolean validateUserExercise(Integer userId, Integer exerciseId) {
        return checkUserIdAndExerciseId(userId, exerciseId);
    }

    private boolean checkUserIdAndExerciseId(Integer userId, Integer exerciseId) {
        final boolean existsByUserIdAndExerciseId = userExerciseRepository.existsByUserIdAndExerciseId(userId, exerciseId);
        if (!existsByUserIdAndExerciseId) {
            log.warn("User ID {userId} hasn't studied exercise ID {exerciseId}");
        }

        return existsByUserIdAndExerciseId;
    }
}
