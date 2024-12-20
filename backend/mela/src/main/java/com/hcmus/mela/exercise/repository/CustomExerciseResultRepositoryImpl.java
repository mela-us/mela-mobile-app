package com.hcmus.mela.exercise.repository;

import com.hcmus.mela.exercise.model.ExerciseResult;
import com.hcmus.mela.exercise.model.ExerciseResultCount;
import com.hcmus.mela.exercise.model.ExerciseStatus;
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
public class CustomExerciseResultRepositoryImpl implements CustomExerciseResultRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public ExerciseResult getBestExerciseResult(UUID userId, UUID exerciseId) {
        MatchOperation matchStage = Aggregation.match(Criteria.where("user_id").is(userId).and("exercise_id").is(exerciseId));

        SortOperation sortStage = Aggregation.sort(Sort.Direction.DESC, "total_correct_answers");

        LimitOperation limitStage = Aggregation.limit(1);

        Aggregation aggregation = Aggregation.newAggregation(
                matchStage,
                sortStage,
                limitStage
        );

        List<ExerciseResult> results = mongoTemplate.aggregate(
                aggregation,
                "exercise_results",
                ExerciseResult.class
        ).getMappedResults();

        if (results.isEmpty()) {
            return null;
        }

        return results.get(0);
    }

    @Override
    public List<ExerciseResultCount> countTotalPassExerciseOfLectures(UUID userId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(new Criteria().andOperator(
                        Criteria.where("user_id").is(userId),
                        Criteria.where("status").is(ExerciseStatus.PASS.name())
                )),
                Aggregation.group("lecture_id").addToSet("exercise_id").as("exercises"),
                Aggregation.project("_id").and("exercises").size().as("total")
        );
        AggregationResults<ExerciseResultCount> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_results",
                ExerciseResultCount.class
        );
        return result.getMappedResults();
    }
}
