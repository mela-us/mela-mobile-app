package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.UserExercise;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserExerciseRepository extends MongoRepository<UserExercise, Integer> {

    UserExercise findByUserIdAndExerciseId(Integer userId, Integer exerciseId);

    boolean existsByUserIdAndExerciseId(Integer userId, Integer exerciseId);
}
