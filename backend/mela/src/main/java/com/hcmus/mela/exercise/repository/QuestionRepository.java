package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Question;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface QuestionRepository extends MongoRepository<Question, Integer> {

    Question findByQuestionId(Integer questionId);

    List<Question> findAllByExerciseId(Integer exerciseId);

    boolean existsByQuestionId(Integer questionId);

    boolean existsByExerciseId(Integer exerciseId);
}
