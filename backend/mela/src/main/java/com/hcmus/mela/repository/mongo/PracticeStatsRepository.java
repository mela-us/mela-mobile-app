package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.LectureStats;
import com.hcmus.mela.model.mongo.UserExercise;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface PracticeStatsRepository extends MongoRepository<UserExercise, Integer> {
}

