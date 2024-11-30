package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.model.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class LectureRepositoryImpl implements LectureRepository {

     private final MongoTemplate mongoTemplate;

     @Override
     public Lecture findByLectureId(UUID lectureId) {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.match(
                          Criteria.where("lecture_id").is(lectureId)
                  ),
                  Aggregation.project("lecture_id", "lecture_content")
          );

          AggregationResults<Lecture> result = mongoTemplate.aggregate(aggregation, "lectures", Lecture.class);
          if (result.getMappedResults().isEmpty()) {
               throw new MathContentException("No lecture content available for the id " + lectureId);
          }
          return result.getMappedResults().get(0);
     }

     @Override
     public List<Lecture> findLecturesByFilters(Integer topicId, Integer levelId, String keyword) {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.match(
                          topicId != null && levelId != null ?
                                  new Criteria().andOperator(
                                          Criteria.where("topic_id").is(topicId),
                                          Criteria.where("level_id").is(levelId)
                                  ) :
                                  new Criteria()
                  ),
                  keyword != null && !keyword.isEmpty() ?
                          Aggregation.match(Criteria.where("lecture_name").regex(".*" + keyword + ".*", "i")) :
                          Aggregation.match(new Criteria()),
                  Aggregation.lookup("exercises", "lecture_id", "lecture_id", "exercises"),
                  Aggregation.project("lecture_id", "lecture_name", "lecture_content", "topic_id", "level_id")
                          .and("exercises").size().as("exercise_count")
          );

          AggregationResults<Lecture> result = mongoTemplate.aggregate(aggregation, "lectures", Lecture.class);
          return result.getMappedResults();
     }
}

