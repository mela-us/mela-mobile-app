package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.model.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
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
     public List<Lecture> findLecturesByTopic(UUID topicId) {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.match(Criteria.where("topic_id").is(topicId)),
                  Aggregation.project("_id", "level_id", "topic_id", "name", "description")
          );
          AggregationResults<Lecture> result = mongoTemplate.aggregate(aggregation, "lectures", Lecture.class);
          return result.getMappedResults();
     }

     @Override
     public List<Lecture> findLecturesByKeyword(String keyword) {
          Aggregation aggregation = Aggregation.newAggregation(
                  (keyword != null && !keyword.isEmpty())
                          ? Aggregation.match(Criteria.where("name").regex(keyword, "i"))
                          : Aggregation.match(new Criteria()),
                  Aggregation.project("_id", "level_id", "topic_id", "name", "description")
          );
          AggregationResults<Lecture> result = mongoTemplate.aggregate(aggregation, "lectures", Lecture.class);
          return result.getMappedResults();
     }

     @Override
     public List<Lecture> findLectureByRecent(Integer size) {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.sort(Sort.by(Sort.Order.desc("end_at"))),
                  Aggregation.group("lecture_id")
                          .first("end_at").as("end_at"),
                  Aggregation.sort(Sort.by(Sort.Order.desc("end_at"))),
                  Aggregation.limit(size),
                  Aggregation.lookup("lectures", "_id","_id", "lecture"),
                  Aggregation.project("_id")
                          .and("lecture.level_id").as("level_id")
                          .and("lecture.topic_id").as("topic_id")
                          .and("lecture.name").as("name")
                          .and("lecture.description").as("description")
          );
          AggregationResults<Lecture> result = mongoTemplate.aggregate(aggregation, "exercise_results", Lecture.class);
          return result.getMappedResults();
     }

     @Override
     public Lecture findLectureSectionsByLecture(UUID lectureId) {
          Aggregation aggregation = Aggregation.newAggregation(
                  Aggregation.match(Criteria.where("_id").is(lectureId))
          );
          AggregationResults<Lecture> result = mongoTemplate.aggregate(aggregation, "lectures", Lecture.class);
          return result.getMappedResults().isEmpty() ? null : result.getMappedResults().get(0);
     }
}

