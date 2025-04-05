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
public class LectureCustomRepositoryImpl implements LectureCustomRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<Lecture> findLecturesByTopicAndLevel(UUID topicId, UUID levelId) {
        Criteria criteria = Criteria.where("topic_id").is(topicId)
                .and("level_id").is(levelId);

        Aggregation aggregation = buildLectureAggregation(criteria);
        return executeLectureAggregation(aggregation);
    }

    @Override
    public List<Lecture> findLecturesByKeyword(String keyword) {
        Criteria criteria = (keyword != null && !keyword.trim().isEmpty())
                ? Criteria.where("name").regex(keyword, "i")
                : new Criteria(); // match all

        Aggregation aggregation = buildLectureAggregation(criteria);
        return executeLectureAggregation(aggregation);
    }

    private Aggregation buildLectureAggregation(Criteria matchCriteria) {
        return Aggregation.newAggregation(
                Aggregation.match(matchCriteria),
                Aggregation.project("_id", "level_id", "topic_id", "ordinal_number", "name", "description"),
                Aggregation.lookup("exercises", "_id", "lecture_id", "exercises"),
                Aggregation.project("_id", "level_id", "topic_id", "ordinal_number", "name", "description")
                        .and("exercises").size().as("total_exercises")
        );
    }

    private List<Lecture> executeLectureAggregation(Aggregation aggregation) {
        AggregationResults<Lecture> results = mongoTemplate.aggregate(aggregation, "lectures", Lecture.class);
        return results.getMappedResults();
    }
}