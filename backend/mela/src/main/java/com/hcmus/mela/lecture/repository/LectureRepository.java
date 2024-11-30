package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;

import java.util.List;
import java.util.UUID;

public interface LectureRepository {
     Lecture findByLectureId(UUID lectureId) throws Exception;
     List<Lecture> findLecturesByFilters(Integer topicId, Integer levelId, String keyword);
}

