package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.Exercise;
import lombok.AllArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

@AllArgsConstructor
public class ExerciseCustomRepositoryImpl implements ExerciseCustomRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public Exercise updateQuestionHint(Exercise exercise) {
        Query query = new Query(Criteria.where("_id").is(exercise.getExerciseId()));

        Update update = new Update().set("questions", exercise.getQuestions());

        return mongoTemplate.findAndModify(query, update, Exercise.class);
    }
}
