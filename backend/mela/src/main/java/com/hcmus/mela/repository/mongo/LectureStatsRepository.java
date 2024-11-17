package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.dto.service.LectureDto;
import com.hcmus.mela.model.mongo.LectureStats;

import java.util.List;

public interface LectureStatsRepository {
    List<LectureStats> findLectureStatsListByUserId(Integer userId);
}

