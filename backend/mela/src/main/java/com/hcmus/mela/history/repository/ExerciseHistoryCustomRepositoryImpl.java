package com.hcmus.mela.history.repository;

import com.hcmus.mela.history.model.BestResultByExercise;
import com.hcmus.mela.history.model.ExercisesCountByLecture;
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
}
