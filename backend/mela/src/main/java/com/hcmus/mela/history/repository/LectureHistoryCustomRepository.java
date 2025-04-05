package com.hcmus.mela.history.repository;

import com.hcmus.mela.history.model.LectureByTime;

import java.util.List;
import java.util.UUID;

public interface LectureHistoryCustomRepository {

    List<LectureByTime> getRecentLecturesBySectionOfUser(UUID userId);
}
