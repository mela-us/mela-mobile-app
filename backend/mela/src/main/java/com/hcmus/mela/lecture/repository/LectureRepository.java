package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.model.LectureSection;

import java.util.List;
import java.util.UUID;

public interface LectureRepository {

     List<Lecture> findLecturesByTopic(UUID topicId);

     List<Lecture> findLecturesByKeyword(String keyword);

     List<Lecture> findLectureByRecent(Integer size);

     Lecture findLectureSectionsByLecture(UUID lectureId);
}

