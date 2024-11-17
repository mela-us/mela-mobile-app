package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.UserExerciseDto;
import com.hcmus.mela.model.mongo.UserExercise;

public interface UserExerciseService {

    UserExercise findByUserIdAndExerciseId(Integer userId, Integer exerciseId);

    UserExerciseDto getUserExercise(Integer userId, Integer exerciseId);
}
