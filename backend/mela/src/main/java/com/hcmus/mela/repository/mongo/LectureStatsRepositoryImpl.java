package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.ExerciseStatus;
import com.hcmus.mela.model.mongo.LectureStats;
import lombok.RequiredArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class LectureStatsRepositoryImpl implements LectureStatsRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<LectureStats> findLectureStatsListByUserId(Integer userId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.lookup("user_exercises", "exercise_id", "exercise_id", "user_exercises"),
                Aggregation.match(
                        Criteria.where("user_exercises.user_id").is(userId)
                                .and("user_exercises.status").is(ExerciseStatus.PASS.name())
                ),
                Aggregation.project()
                        .and("lecture_id").as("lecture_id")
                        .and("user_exercises").size().as("pass_count"),
                Aggregation.group("lecture_id").sum("pass_count").as("pass_count")
        );

        AggregationResults<LectureStats> result = mongoTemplate.aggregate(aggregation, "exercises", LectureStats.class);
        return result.getMappedResults();
    }
}

