package com.hcmus.mela.statistic.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.statistic.dto.response.GetStatisticsResponse;
import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.service.ExerciseInfoService;
import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.dto.dto.LectureCompletedSectionDto;
import com.hcmus.mela.history.dto.dto.LectureHistoryDto;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.history.service.LectureHistoryService;
import com.hcmus.mela.lecture.dto.dto.LectureDto;
import com.hcmus.mela.lecture.dto.dto.SectionDto;
import com.hcmus.mela.lecture.dto.dto.TopicDto;
import com.hcmus.mela.lecture.service.LectureService;
import com.hcmus.mela.lecture.service.TopicService;
import com.hcmus.mela.statistic.dto.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StatisticServiceImpl implements StatisticService  {

    private final JwtTokenService jwtTokenService;

    private final LectureHistoryService lectureHistoryService;

    private final TopicService topicService;

    private final LectureService lectureService;

    private final ExerciseInfoService exerciseInfoService;

    private final ExerciseHistoryService exerciseHistoryService;

    public GetStatisticsResponse getStatisticByUserAndLevelAndType(String authorizationHeader, UUID levelId, ActivityType activityType) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));
        List<ActivityHistoryDto> activityHistoryDtoList = new ArrayList<>();
        if (activityType == ActivityType.SECTION) {
            List<ActivityHistoryDto> activityFromLectureHistory = getActivityFromLectureHistory(userId, levelId);
            if (!activityFromLectureHistory.isEmpty()) {
                activityHistoryDtoList.addAll(activityFromLectureHistory);
            }
        } else if (activityType == ActivityType.EXERCISE) {
            List<ActivityHistoryDto> activityFromExerciseHistory = getActivityFromExerciseHistory(userId, levelId);
            if (!activityFromExerciseHistory.isEmpty()) {
                activityHistoryDtoList.addAll(activityFromExerciseHistory);
            }
        } else {
            List<ActivityHistoryDto> activityFromLectureHistory = getActivityFromLectureHistory(userId, levelId);
            List<ActivityHistoryDto> activityFromExerciseHistory = getActivityFromExerciseHistory(userId, levelId);
            if (!activityFromLectureHistory.isEmpty()) {
                activityHistoryDtoList.addAll(activityFromLectureHistory);
            }
            if (!activityFromExerciseHistory.isEmpty()) {
                activityHistoryDtoList.addAll(activityFromExerciseHistory);
            }
        }
        activityHistoryDtoList.sort((o1, o2) -> o2.getLatestDate().compareTo(o1.getLatestDate()));

        return new GetStatisticsResponse(
                "Get statistic successfully!",
                activityHistoryDtoList.size(),
                activityHistoryDtoList);
    }

    private List<ActivityHistoryDto> getActivityFromLectureHistory(UUID userId, UUID levelId) {
        List<TopicDto> topicDtoList = topicService.getTopics();
        Map<UUID, String> topicNameMap = topicDtoList.stream().collect(Collectors.toMap(TopicDto::getTopicId, TopicDto::getName));

        List<LectureHistoryDto> lectureHistoryDtoList = lectureHistoryService.getLectureHistoryByUserAndLevel(userId, levelId);
        List<ActivityHistoryDto> activityHistoryDtoList = new ArrayList<>();

        for (LectureHistoryDto lectureHistoryDto : lectureHistoryDtoList) {
            LectureDto lectureDto = lectureService.getLectureById(lectureHistoryDto.getLectureId());
            String lectureName = lectureDto.getName();
            Map<Integer, String> sectionNameMap = lectureDto.getSections().stream().collect(Collectors.toMap(SectionDto::getOrdinalNumber, SectionDto::getName));

            String topicName = topicNameMap.get(lectureDto.getTopicId());
            for (LectureCompletedSectionDto section : lectureHistoryDto.getCompletedSections()) {
                ActivityHistoryDto activityHistoryDto = new ActivityHistoryDto();
                activityHistoryDto.setType(ActivityType.SECTION);
                activityHistoryDto.setLatestDate(section.getCompletedAt());
                activityHistoryDto.setTopicName(topicName);
                activityHistoryDto.setLectureName(lectureName);
                activityHistoryDto.setSection(new SectionActivityDto(sectionNameMap.get(section.getOrdinalNumber()), section.getCompletedAt()));
                activityHistoryDtoList.add(activityHistoryDto);
            }
        }
        return activityHistoryDtoList;
    }

    private List<ActivityHistoryDto> getActivityFromExerciseHistory(UUID userId, UUID levelId) {
        List<ExerciseHistoryDto> exerciseHistoryDtoList = exerciseHistoryService.getExerciseHistoryByUserAndLevel(userId, levelId);
        if (exerciseHistoryDtoList == null || exerciseHistoryDtoList.isEmpty()) {
            return new ArrayList<>();
        }

        Map<UUID, List<ExerciseHistoryDto>> exerciseHistoryListDtoMap = new HashMap<>();
        for (ExerciseHistoryDto exerciseHistoryDto : exerciseHistoryDtoList) {
            exerciseHistoryListDtoMap
                    .computeIfAbsent(exerciseHistoryDto.getExerciseId(), k -> new ArrayList<>())
                    .add(exerciseHistoryDto);
        }


        List<TopicDto> topicDtoList = topicService.getTopics();
        Map<UUID, String> topicNameMap = topicDtoList.stream().collect(Collectors.toMap(TopicDto::getTopicId, TopicDto::getName));

        List<ActivityHistoryDto> activityHistoryDtoList = new ArrayList<>();
        for (UUID exerciseId : exerciseHistoryListDtoMap.keySet()) {
            ActivityHistoryDto activityHistoryDto = new ActivityHistoryDto();
            ExerciseActivityDto exerciseActivityDto = new ExerciseActivityDto();
            activityHistoryDto.setExercise(exerciseActivityDto);
            exerciseActivityDto.setScoreRecords(new ArrayList<>());

            LectureDto lectureDto = lectureService.getLectureById(exerciseHistoryListDtoMap.get(exerciseId).get(0).getLectureId());
            ExerciseDto exerciseDto = exerciseInfoService.findByExerciseId(exerciseId);

            for (ExerciseHistoryDto exerciseHistoryDto : exerciseHistoryListDtoMap.get(exerciseId)) {
                ScoreRecordDto scoreRecordDto = new ScoreRecordDto(exerciseHistoryDto.getCompletedAt(), exerciseHistoryDto.getScore());
                exerciseActivityDto.getScoreRecords().add(scoreRecordDto);
                exerciseActivityDto.getScoreRecords().sort((o1, o2) -> o2.getDate().compareTo(o1.getDate()));
            }
            ScoreRecordDto lastestScoreRecord = exerciseActivityDto.getScoreRecords().get(0);

            activityHistoryDto.setType(ActivityType.EXERCISE);
            activityHistoryDto.setLatestDate(lastestScoreRecord.getDate());
            activityHistoryDto.setTopicName(topicNameMap.get(lectureDto.getTopicId()));
            activityHistoryDto.setLectureName(lectureDto.getName());

            exerciseActivityDto.setExerciseName(exerciseDto.getExerciseName());
            exerciseActivityDto.setLatestScore(lastestScoreRecord.getScore());

            activityHistoryDtoList.add(activityHistoryDto);
        }

        return activityHistoryDtoList;
    }
}