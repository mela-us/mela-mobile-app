package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.exceptions.custom.MathContentException;
import com.hcmus.mela.model.mongo.Exercise;
import com.hcmus.mela.model.mongo.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ExerciseRepositoryImpl implements ExerciseRepository {

     private final MongoTemplate mongoTemplate;

     @Override
     public List<Exercise> findExercisesByLectureId(Integer lectureId) {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.match(
                          Criteria.where("lecture_id").is(lectureId)
                  ),
                  Aggregation.lookup("questions", "exercise_id", "exercise_id", "questions"),
                  Aggregation.project("exercise_id", "lecture_id", "exercise_name", "exercise_number")
                          .and("questions").size().as("questions_count"),
                  Aggregation.sort(Sort.by(Sort.Order.asc("question_count")))
          );
          AggregationResults<Exercise> result = mongoTemplate.aggregate(aggregation, "exercises", Exercise.class);
          return result.getMappedResults();
     }
}

