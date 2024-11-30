package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;

import java.util.UUID;

public interface LectureService {

    GetLecturesResponse getLecturesByTopic(String authorizationHeader, UUID topicId);

    GetLecturesResponse getLecturesByKeyword(String authorizationHeader, String keyword);

    GetLecturesResponse getLecturesByRecent(String authorizationHeader, Integer size);

    GetLectureSectionsResponse getLectureSections(UUID lectureId);
}