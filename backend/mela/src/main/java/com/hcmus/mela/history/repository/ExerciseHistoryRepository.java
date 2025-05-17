package com.hcmus.mela.history.repository;

import com.hcmus.mela.history.model.ExerciseHistory;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.UUID;

public interface ExerciseHistoryRepository extends MongoRepository<ExerciseHistory, UUID>, ExerciseHistoryCustomRepository {

    List<ExerciseHistory> findAllByUserIdAndLevelId(UUID userId, UUID levelId);
}
