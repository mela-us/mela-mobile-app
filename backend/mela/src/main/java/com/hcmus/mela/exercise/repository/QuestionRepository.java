package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Question;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface QuestionRepository extends MongoRepository<Question, UUID> {

    Question findByQuestionId(UUID questionId);

    Boolean existsByQuestionId(UUID questionId);


}
