package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.LectureStats;

import java.util.List;

public interface LectureStatsRepository {
    List<LectureStats> findLectureStatsListByUserId(Integer userId);
}

