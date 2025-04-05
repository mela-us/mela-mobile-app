package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Exercise;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.UUID;

public interface ExerciseRepository extends MongoRepository<Exercise, UUID>, ExerciseCustomRepository {

    Exercise findByExerciseId(UUID exerciseId);

    Exercise findByQuestionsQuestionId(UUID questionId);

    List<Exercise> findAllByLectureId(UUID lectureId);

    Boolean existsByExerciseId(UUID exerciseId);

    Boolean existsByLectureId(UUID lectureId);
}
