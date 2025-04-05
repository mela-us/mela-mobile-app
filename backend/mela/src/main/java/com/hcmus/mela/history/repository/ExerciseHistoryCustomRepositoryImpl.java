package com.hcmus.mela.history.repository;

import com.hcmus.mela.history.model.BestResultByExercise;
import com.hcmus.mela.history.model.ExercisesCountByLecture;
import com.hcmus.mela.history.model.LectureByTime;
import com.mongodb.BasicDBObject;
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
public class ExerciseHistoryCustomRepositoryImpl implements ExerciseHistoryCustomRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<ExercisesCountByLecture> countTotalPassExerciseOfUser(UUID userId, Double passScore) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId),
                        Criteria.where("score").gte(passScore)
                )),
                Aggregation.group("lecture_id").addToSet("exercise_id").as("exercises"),
                Aggregation.project("_id").and("exercises").size().as("total")
        );
        AggregationResults<ExercisesCountByLecture> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_histories",
                ExercisesCountByLecture.class
        );
        return result.getMappedResults();
    }

    @Override
    public List<BestResultByExercise> getBestExerciseResultsOfUserByLectureId(UUID userId, UUID lectureId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId),
                        Criteria.where("lecture_id").is(lectureId)
                )),
                Aggregation.sort(Sort.Direction.DESC, "score"),
                Aggregation.group("exercise_id").first("score").as("score"),
                Aggregation.project().and("_id").as("exercise_id")
                        .and("score").as("score")
        );
        AggregationResults<BestResultByExercise> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_histories",
                BestResultByExercise.class
        );
        return result.getMappedResults();
    }

    @Override
    public List<LectureByTime> getRecentLecturesByExercisesOfUser(UUID userId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId)
                )),
                Aggregation.sort(Sort.Direction.DESC, "completed_at"),
                Aggregation.group("lecture_id").first("completed_at").as("completed_at"),
                Aggregation.project().and("_id").as("lecture_id")
                        .and("completed_at").as("completed_at")
        );
        AggregationResults<LectureByTime> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_histories",
                LectureByTime.class
        );
        return result.getMappedResults();
    }

    @Override
    public List<Object> getExerciseActivityOfUserByLevelId(UUID userId, UUID levelId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId),
                        Criteria.where("level_id").is(levelId)
                )),
                Aggregation.project("lecture_id", "topic_id", "exercise_id", "score", "completed_at"),
                Aggregation.sort(Sort.Direction.DESC, "completed_at"),
                Aggregation.group("exercise_id", "lecture_id", "topic_id")
                        .first("completed_at").as("latest_completed_at")
                        .first("score").as("latest_score")
                        // Push an array of objects containing both complete_date and score
                        .push(
                                new BasicDBObject("date", "$completed_at")
                                        .append("score", "$score")
                        ).as("records"),
                Aggregation.project()
                        .and("_id.lecture_id").as("lecture_id")
                        .and("_id.topic_id").as("topic_id")
                        .and("_id.exercise_id").as("exercise_id")
                        .and("latest_score").as("latest_score")
                        .and("latest_completed_at").as("latest_completed_at")
                        .and("records").as("records")
        );
        AggregationResults<Object> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_histories",
                Object.class
        );
        return result.getMappedResults();
    }
}
