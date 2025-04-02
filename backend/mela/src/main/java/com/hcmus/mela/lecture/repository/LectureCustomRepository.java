package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;

import java.util.List;
import java.util.UUID;

public interface LectureCustomRepository {

    List<Lecture> findLecturesByTopicAndLevel(UUID topicId, UUID levelId);

    List<Lecture> findLecturesByKeyword(String keyword);
}
