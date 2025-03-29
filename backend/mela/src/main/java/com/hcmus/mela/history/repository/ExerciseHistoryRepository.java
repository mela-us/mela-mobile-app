package com.hcmus.mela.history.repository;

import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.history.model.ExerciseHistory;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;
import java.util.UUID;

public interface ExerciseHistoryRepository extends MongoRepository<ExerciseHistory, UUID> {

    List<ExerciseHistory> findAllByUserId(UUID userId);

    @Query("{ 'userId': ?0, 'lectureId': { '$in': ?1 }, 'score': { '$gte': ?2 } }")
    List<ExerciseHistory> findAllByUserIdAndLectureIdListAndScoreAboveOrEqual(UUID userId, List<UUID> lectureIdList, Double num);

    @Query("{ 'userId': ?0, 'exerciseId': { '$in': ?1 } }")
    List<ExerciseHistory> findAllByUserIdAndExerciseIdList(UUID userId, List<UUID> exerciseIdList);

    @Query("{ 'userId': ?0 }")
    List<ExerciseHistory> findAllByUserIdOrderByCompletedAtDesc(UUID userId);

    List<ExerciseHistory> findAllByUserIdAndLevelId(UUID userId, UUID levelId);
}
