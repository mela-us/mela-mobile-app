package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.ExerciseResult;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.UUID;

public interface ExerciseResultRepository extends MongoRepository<ExerciseResult, UUID> {

    List<ExerciseResult> findAllByUserIdAndExerciseId(UUID userId, UUID exerciseId);

    Boolean existsByUserIdAndExerciseId(UUID userId, UUID exerciseId);
}

