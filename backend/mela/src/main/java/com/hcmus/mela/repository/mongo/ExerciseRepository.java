package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Exercise;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface ExerciseRepository extends MongoRepository<Exercise, Integer> {
    Exercise findByExerciseId(Integer exerciseId);

    List<Exercise> findAllByLectureId(Integer lectureId);

    boolean existsByExerciseId(Integer exerciseId);

    boolean existsByLectureId(Integer lectureId);
}
