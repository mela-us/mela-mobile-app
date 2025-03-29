package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;
import java.util.UUID;

public interface LectureRepository extends MongoRepository<Lecture, UUID> {

    Lecture findByLectureId(UUID lectureId);

    List<Lecture> findAllByLevelIdAndTopicId(UUID levelId, UUID topicId);

    List<Lecture> findAllByNameContainingIgnoreCase(String keyword);

    @Query("{ 'lectureId': { '$in': ?0 } }")
    List<Lecture> findAllByLectureIdList(List<UUID> lectureIdList);
}
