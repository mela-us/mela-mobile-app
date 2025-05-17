package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseDto;

import java.util.UUID;

public interface ExerciseInfoService {

    ExerciseDto findByExerciseId(UUID exerciseId);
}
