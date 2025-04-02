package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.LecturesByTopicDto;
import com.hcmus.mela.lecture.dto.response.GetLecturesByLevelResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;

import java.util.List;
import java.util.UUID;

public interface LectureListService {

    GetLecturesByLevelResponse getLecturesByLevel(UUID userId, UUID levelId);

    GetLecturesResponse getLecturesByKeyword(UUID userId, String keyword);

    GetLecturesResponse getLecturesByRecent(UUID userId, Integer size);
}