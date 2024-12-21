package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Exercise;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;
import java.util.UUID;

public interface ExerciseRepository extends MongoRepository<Exercise, UUID> {
    Exercise findByExerciseId(UUID exerciseId);

    List<Exercise> findAllByLectureId(UUID lectureId);

    Boolean existsByExerciseId(UUID exerciseId);

    Boolean existsByLectureId(UUID lectureId);
}
