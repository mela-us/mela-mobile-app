package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;

import java.util.List;

public interface LectureRepository {
     Lecture findByLectureId(Integer lectureId) throws Exception;
     List<Lecture> findLecturesByFilters(Integer topicId, Integer levelId, String keyword);
}

