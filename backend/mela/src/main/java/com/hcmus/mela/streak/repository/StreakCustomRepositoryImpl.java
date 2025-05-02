package com.hcmus.mela.streak.repository;

import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.streak.model.Streak;
import lombok.AllArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

@AllArgsConstructor
public class StreakCustomRepositoryImpl implements StreakCustomRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public Streak updateStreak(Streak streak) {
        Query query = new Query(Criteria.where("_id").is(streak.getUserId()));

        Update update = new Update().set("streak_days", streak.getStreakDays())
                .set("started_at", streak.getStartedAt())
                .set("updated_at", streak.getUpdatedAt())
                .set("longest_streak", streak.getLongestStreak());

        return mongoTemplate.findAndModify(query, update, Streak.class);
    }
}
