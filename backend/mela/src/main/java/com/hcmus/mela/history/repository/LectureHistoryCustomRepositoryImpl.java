package com.hcmus.mela.history.repository;

import com.hcmus.mela.history.model.LectureByTime;
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
public class LectureHistoryCustomRepositoryImpl implements LectureHistoryCustomRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<LectureByTime> getRecentLecturesBySectionOfUser(UUID userId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId)
                )),
                Aggregation.project("lecture_id", "completed_sections"),
                Aggregation.unwind("completed_sections"),
                Aggregation.sort(Sort.Direction.DESC, "completed_sections.completed_at"),
                Aggregation.group("lecture_id").first("completed_sections.completed_at").as("completed_at"),
                Aggregation.project().and("_id").as("lecture_id")
                        .and("completed_at").as("completed_at")
        );
        AggregationResults<LectureByTime> result = mongoTemplate.aggregate(
                aggregation,
                "lecture_histories",
                LectureByTime.class
        );
        return result.getMappedResults();
    }

    @Override
    public List<Object> getSectionActivityOfUserByLevelId(UUID userId, UUID levelId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId),
                        Criteria.where("level_id").is(levelId)
                )),
                Aggregation.project("lecture_id", "topic_id", "completed_sections"),
                Aggregation.unwind("completed_sections"),
                Aggregation.project("lecture_id", "topic_id")
                        .and("completed_sections.completed_at").as("completed_at")
                        .and("completed_sections.ordinal_number").as("ordinal_number"),
                Aggregation.sort(Sort.Direction.DESC, "completed_at")
        );
        AggregationResults<Object> result = mongoTemplate.aggregate(
                aggregation,
                "lecture_histories",
                Object.class
        );
        return result.getMappedResults();
    }
}
