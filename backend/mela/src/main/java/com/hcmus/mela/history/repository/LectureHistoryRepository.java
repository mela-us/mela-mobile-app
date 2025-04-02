package com.hcmus.mela.history.repository;

import com.hcmus.mela.history.model.LectureHistory;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.mongodb.repository.Update;

import java.util.List;
import java.util.UUID;

public interface LectureHistoryRepository extends MongoRepository<LectureHistory, UUID>, LectureHistoryCustomRepository {

    LectureHistory findByLectureIdAndUserId(UUID lectureId, UUID userId);

    @Query("{ '_id': ?0 }")
    @Update("{ '$set': ?1 }")
    void updateFirstById(UUID id, LectureHistory lectureHistory);

    @Query("{ 'userId': ?0 }")
    List<LectureHistory> findAllByUserId(UUID userId);

    List<LectureHistory> findAllByUserIdAndLevelId(UUID userId, UUID levelId);
}