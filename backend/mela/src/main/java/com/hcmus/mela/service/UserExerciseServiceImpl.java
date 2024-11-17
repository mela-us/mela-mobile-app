package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.UserExerciseDto;
import com.hcmus.mela.model.mongo.UserExercise;
import com.hcmus.mela.repository.mongo.UserExerciseRepository;
import com.hcmus.mela.security.mapper.UserExerciseMapper;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserExerciseServiceImpl implements UserExerciseService {

    private final UserExerciseRepository userExerciseRepository;
    private final UserExerciseValidationService userExerciseValidationService;

    @Override
    public UserExercise findByUserIdAndExerciseId(Integer userId, Integer exerciseId) {
        return userExerciseRepository.findByUserIdAndExerciseId(userId, exerciseId);
    }

    @Override
    public UserExerciseDto getUserExercise(Integer userId, Integer exerciseId) {
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
