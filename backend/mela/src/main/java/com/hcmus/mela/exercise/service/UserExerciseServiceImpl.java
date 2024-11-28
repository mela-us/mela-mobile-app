package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.UserExerciseDto;
import com.hcmus.mela.exercise.model.UserExercise;
import com.hcmus.mela.exercise.repository.UserExerciseRepository;
import com.hcmus.mela.exercise.mapper.UserExerciseMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExerciseServiceImpl implements UserExerciseService {

    private final UserExerciseRepository userExerciseRepository;
    private final UserExerciseValidationService userExerciseValidationService;

    @Override
    public UserExercise findByUserIdAndExerciseId(UUID userId, Integer exerciseId) {
        return userExerciseRepository.findByUserIdAndExerciseId(userId, exerciseId);
    }

    @Override
    public UserExerciseDto getUserExercise(UUID userId, Integer exerciseId) {
        final boolean studiedExercise = userExerciseValidationService.validateUserExercise(userId, exerciseId);
        UserExerciseDto userExerciseDto;

        if (!studiedExercise) {
            userExerciseDto = null;
        }
        else {
            UserExercise userExercise = findByUserIdAndExerciseId(userId, exerciseId);
            userExerciseDto = UserExerciseMapper.INSTANCE.convertToUserExerciseDto(userExercise);
        }

        return userExerciseDto;
    }
}
