package com.hcmus.mela.exercise.service;

import com.hcmus.mela.history.dto.dto.ExerciseAnswerDto;

import java.util.List;
import java.util.UUID;

public interface ExerciseResultService {

    void checkResult(UUID exerciseId, List<ExerciseAnswerDto> exerciseAnswerDtoList);
}
