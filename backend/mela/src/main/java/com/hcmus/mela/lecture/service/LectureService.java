package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;

import java.util.UUID;

public interface LectureService {
    public GetLecturesResponse getLecturesByTopic(String authorizationHeader, UUID topicId);

    public GetLecturesResponse getLecturesByKeyword(String authorizationHeader, String keyword);

    public GetLecturesResponse getLecturesByRecent(String authorizationHeader, Integer size);

    public GetLectureSectionsResponse getLectureSections(UUID lectureId);

}