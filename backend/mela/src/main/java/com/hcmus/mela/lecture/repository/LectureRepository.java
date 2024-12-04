package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;

import java.util.List;
import java.util.UUID;

public interface LectureRepository {

    Lecture findById(UUID lectureId);

    List<Lecture> findLecturesByTopic(UUID topicId);

    List<Lecture> findLecturesByKeyword(String keyword);

    List<Lecture> findLectureByRecent(Integer size);
}

