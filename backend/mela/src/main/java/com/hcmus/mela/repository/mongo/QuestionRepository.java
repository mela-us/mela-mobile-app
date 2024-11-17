package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Exercise;
import com.hcmus.mela.model.mongo.Question;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface QuestionRepository extends MongoRepository<Question, Integer> {

    Question findByQuestionId(Integer questionId);

    List<Question> findAllByExerciseId(Integer exerciseId);

    boolean existsByQuestionId(Integer questionId);

    boolean existsByExerciseId(Integer exerciseId);
}
