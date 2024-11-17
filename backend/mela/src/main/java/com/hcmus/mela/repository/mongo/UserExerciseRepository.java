package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.UserExercise;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserExerciseRepository extends MongoRepository<UserExercise, Integer> {

    UserExercise findByUserIdAndExerciseId(Integer userId, Integer exerciseId);

    boolean existsByUserIdAndExerciseId(Integer userId, Integer exerciseId);
}
