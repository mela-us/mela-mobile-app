package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.UserExerciseDto;
import com.hcmus.mela.exercise.model.UserExercise;

public interface UserExerciseService {

    UserExercise findByUserIdAndExerciseId(Integer userId, Integer exerciseId);

    UserExerciseDto getUserExercise(Integer userId, Integer exerciseId);
}
