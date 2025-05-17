package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.mapper.ExerciseMapper;
import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.repository.ExerciseRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;


@Slf4j
@Service
@RequiredArgsConstructor
public class ExerciseInfoServiceImpl implements ExerciseInfoService {

    private final ExerciseRepository exerciseRepository;

    @Override
    public ExerciseDto findByExerciseId(UUID exerciseId) {
        Exercise exercise = exerciseRepository.findByExerciseId(exerciseId);
        return exercise == null
                ? null
                : ExerciseMapper.INSTANCE.converToExerciseDto(exercise);
    }
}
