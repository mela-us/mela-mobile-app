package com.hcmus.mela.history.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.model.ExerciseStatus;
import com.hcmus.mela.exercise.service.ExerciseInfoService;
import com.hcmus.mela.exercise.service.ExerciseResultService;
import com.hcmus.mela.history.dto.dto.CheckedAnswerDto;
import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.mapper.ExerciseHistoryMapper;
import com.hcmus.mela.history.mapper.RecentActivityMapper;
import com.hcmus.mela.history.model.ExerciseAnswer;
import com.hcmus.mela.history.model.ExerciseHistory;
import com.hcmus.mela.history.model.ExercisesCountByLecture;
import com.hcmus.mela.history.model.LectureByTime;
import com.hcmus.mela.history.repository.ExerciseHistoryRepository;
import com.hcmus.mela.history.repository.LectureHistoryRepository;
import com.hcmus.mela.lecture.dto.dto.LectureDto;
import com.hcmus.mela.lecture.service.LectureService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ActivityServiceImpl implements ActivityService {

    private final ExerciseHistoryRepository exerciseHistoryRepository;

    private final LectureHistoryRepository lectureHistoryRepository;

    @Override
    public List<RecentActivityDto> getRecentActivityOfUser(UUID userId, Integer size) {
        CompletableFuture<List<LectureByTime>> sectionsFuture = CompletableFuture.supplyAsync(() ->
                lectureHistoryRepository.getRecentLecturesBySectionOfUser(userId));

        CompletableFuture<List<LectureByTime>> exercisesFuture = CompletableFuture.supplyAsync(() ->
                exerciseHistoryRepository.getRecentLecturesByExercisesOfUser(userId));

        CompletableFuture.allOf(sectionsFuture, exercisesFuture).join();

        List<LectureByTime> sectionsByTimeList = sectionsFuture.join();
        List<LectureByTime> exercisesByTimeList = exercisesFuture.join();

        Map<UUID, LocalDateTime> lectureCompletedAtMap = new HashMap<>();

        if (!sectionsByTimeList.isEmpty()) {
            lectureCompletedAtMap = sectionsByTimeList.stream()
                    .collect(Collectors.toMap(LectureByTime::getLectureId, LectureByTime::getCompletedAt));
        }

        for (LectureByTime lectureByTime : exercisesByTimeList) {
            if (lectureCompletedAtMap.containsKey(lectureByTime.getLectureId())) {
                LocalDateTime completedAt = lectureCompletedAtMap.get(lectureByTime.getLectureId());
                if (completedAt.isAfter(lectureByTime.getCompletedAt())) {
                    lectureCompletedAtMap.put(lectureByTime.getLectureId(), lectureByTime.getCompletedAt());
                }
            } else {
                lectureCompletedAtMap.put(lectureByTime.getLectureId(), lectureByTime.getCompletedAt());
            }
        }

        if (lectureCompletedAtMap.isEmpty()) {
            return Collections.emptyList();
        }

        return lectureCompletedAtMap.entrySet().stream()
                .map(entry -> RecentActivityDto.builder()
                        .lectureId(entry.getKey())
                        .date(entry.getValue())
                        .build())
                .sorted(Comparator.comparing(RecentActivityDto::getDate).reversed())
                .limit(size)
                .toList();
    }
}
