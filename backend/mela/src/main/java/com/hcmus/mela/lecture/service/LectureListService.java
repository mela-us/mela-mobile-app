package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.response.GetLecturesByLevelResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;

import java.util.UUID;

public interface LectureListService {

    GetLecturesByLevelResponse getLecturesByLevel(String authorizationHeader, UUID levelId);

    GetLecturesResponse getLecturesByKeyword(String authorizationHeader, String keyword);

    GetLecturesResponse getLecturesByRecent(String authorizationHeader, int size);
}