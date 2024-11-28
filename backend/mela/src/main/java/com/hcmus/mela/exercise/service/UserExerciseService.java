package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.UserExerciseDto;
import com.hcmus.mela.exercise.model.UserExercise;

import java.util.UUID;

public interface UserExerciseService {

    UserExercise findByUserIdAndExerciseId(UUID userId, Integer exerciseId);

    UserExerciseDto getUserExercise(UUID userId, Integer exerciseId);
}
