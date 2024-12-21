package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.model.Lecture;

import java.util.UUID;

public interface LectureDetailService {

    Lecture getLectureById(UUID lectureId);

    GetLectureSectionsResponse getLectureSections(UUID lectureId);
}