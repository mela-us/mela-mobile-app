package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.model.LectureExerciseTotal;
import com.hcmus.mela.lecture.model.Status;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ExerciseCountRepositoryImpl implements ExerciseCountRepository {

     private final MongoTemplate mongoTemplate;

     @Override
     public List<LectureExerciseTotal> countTotalExerciseOfLectures() {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.group("lecture_id").count().as("total")
          );
          AggregationResults<LectureExerciseTotal> result = mongoTemplate.aggregate(aggregation, "exercises", LectureExerciseTotal.class);
          return result.getMappedResults();
     }

     @Override
     public List<LectureExerciseTotal> countTotalPassExerciseOfLectures(UUID userId)  {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.match(new Criteria().andOperator(
                          Criteria.where("user_id").is(userId),
                          Criteria.where("status").is(Status.PASS.name())
                  )),
                  Aggregation.group("lecture_id").addToSet("exercise_id").as("exercises"),
                  Aggregation.project("_id").and("exercises").size().as("total")
          );
          AggregationResults<LectureExerciseTotal> result = mongoTemplate.aggregate(aggregation, "exercise_results", LectureExerciseTotal.class);
          return result.getMappedResults();
     }
}

