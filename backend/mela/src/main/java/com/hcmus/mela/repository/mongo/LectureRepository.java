package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Lecture;

import java.util.List;

public interface LectureRepository {
     Lecture findByLectureId(Integer lectureId) throws Exception;
     List<Lecture> findLecturesByFilters(Integer topicId, Integer levelId, String keyword);
}

