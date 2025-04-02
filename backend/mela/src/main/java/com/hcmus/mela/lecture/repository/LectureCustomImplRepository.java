package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class LectureCustomImplRepository implements LectureCustomRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<Lecture> findLecturesByTopicAndLevel(UUID topicId, UUID levelId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(Criteria.where("topic_id").is(topicId)),
                Aggregation.match(Criteria.where("level_id").is(levelId)),
                Aggregation.project("_id", "level_id", "topic_id", "ordinal_number", "name", "description"),
                Aggregation.lookup("exercises", "_id", "lecture_id", "exercises"),
                Aggregation.project("_id", "level_id", "topic_id", "ordinal_number", "name", "description")
                        .and("exercises").size().as("total_exercises")
        );
        AggregationResults<Lecture> result = mongoTemplate.aggregate(
                aggregation,
                "lectures",
                Lecture.class
        );
        return result.getMappedResults();
    }

    @Override
    public List<Lecture> findLecturesByKeyword(String keyword) {
        Aggregation aggregation = Aggregation.newAggregation(
                (keyword != null && !keyword.isEmpty())
                        ? Aggregation.match(Criteria.where("name").regex(keyword, "i"))
                        : Aggregation.match(new Criteria()),
                Aggregation.project("_id", "level_id", "topic_id", "ordinal_number", "name", "description"),
                Aggregation.lookup("exercises", "_id", "lecture_id", "exercises"),
                Aggregation.project("_id", "level_id", "topic_id", "ordinal_number", "name", "description")
                        .and("exercises").size().as("total_exercises")
        );
        AggregationResults<Lecture> result = mongoTemplate.aggregate(
                aggregation,
                "lectures",
                Lecture.class
        );
        return result.getMappedResults();
    }
}