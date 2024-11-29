package com.hcmus.mela.statistic.repository;

import com.hcmus.mela.statistic.model.DailyQuestionStats;
import com.hcmus.mela.statistic.model.QuestionStats;
import lombok.RequiredArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class StatisticRepositoryImpl implements StatisticRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<QuestionStats> getQuestionStats(UUID userId) {
        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(Criteria.where("user_id").is(userId)),
                Aggregation.group("topic_id", "level_id")
                        .sum("total_correct_answers").as("total_correct_answers")
                        .sum("total_answers").as("total_answers"),
                Aggregation.project("_id")
                        .and("_id.topic_id").as("topic_id")
                        .and("_id.level_id").as("level_id")
                        .and("total_correct_answers").as("total_correct_answers")
                        .and("total_answers").as("total_answers"),
                Aggregation.lookup("topics", "topic_id", "_id", "topic"),
                Aggregation.lookup("levels", "level_id", "_id", "level"),
                Aggregation.unwind("topic"),
                Aggregation.unwind("level")
        );
        AggregationResults<QuestionStats> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_results",
                QuestionStats.class
        );
        return result.getMappedResults();
    }

    @Override
    public List<DailyQuestionStats> getDailyQuestionStatsLast7Days(UUID userId) {
        LocalDate currentDate = LocalDate.now();
        LocalDate date7DaysAgo = currentDate.minusDays(7);

        Aggregation aggregation = Aggregation.newAggregation(
                Aggregation.match(Criteria.where("user_id").is(userId)),
                Aggregation.match(Criteria.where("end_at")
                        .gt(date7DaysAgo)
                        .lte(currentDate)),
                Aggregation.project("end_at")
                        .andExpression("dateToString({'format': '%Y-%m-%d', 'date': '$date_time'})")
                        .as("date")
                        .and("topic_id").as("topic_id")
                        .and("level_id").as("level_id")
        );
        AggregationResults<DailyQuestionStats> result = mongoTemplate.aggregate(
                aggregation,
                "exercise_results",
                DailyQuestionStats.class
        );
        return result.getMappedResults();
    }
}

