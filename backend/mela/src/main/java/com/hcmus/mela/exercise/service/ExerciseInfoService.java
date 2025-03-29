package com.hcmus.mela.exercise.service;
import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.dto.request.ExerciseRequest;
import com.hcmus.mela.exercise.dto.response.ExerciseResponse;
import com.hcmus.mela.exercise.dto.response.QuestionResponse;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface ExerciseInfoService {

    ExerciseDto findByExerciseId(UUID exerciseId);
}
