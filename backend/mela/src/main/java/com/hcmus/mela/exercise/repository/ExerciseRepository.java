package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Exercise;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface ExerciseRepository extends MongoRepository<Exercise, Integer> {
    Exercise findByExerciseId(Integer exerciseId);

    List<Exercise> findAllByLectureId(Integer lectureId);

    boolean existsByExerciseId(Integer exerciseId);

    boolean existsByLectureId(Integer lectureId);
}
