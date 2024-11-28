package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.UserExercise;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface UserExerciseRepository extends MongoRepository<UserExercise, Integer> {

    UserExercise findByUserIdAndExerciseId(UUID userId, Integer exerciseId);

    boolean existsByUserIdAndExerciseId(UUID userId, Integer exerciseId);
}
