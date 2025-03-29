package com.hcmus.mela.lecture.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.exercise.service.ExerciseService;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.history.service.LectureHistoryService;
import com.hcmus.mela.lecture.dto.dto.LectureStatDetailDto;
import com.hcmus.mela.lecture.dto.dto.LecturesByTopicDto;
import com.hcmus.mela.lecture.dto.response.GetLecturesByLevelResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;

import com.hcmus.mela.lecture.mapper.LectureMapper;
import com.hcmus.mela.lecture.mapper.TopicMapper;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.repository.LectureRepository;
import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class LectureListServiceImpl implements LectureListService {

    private final GeneralMessageAccessor generalMessageAccessor;

    private final LectureRepository lectureRepository;

    private final ExerciseHistoryService exerciseHistoryService;

    private final LectureHistoryService lectureHistoryService;

    private final ExerciseService exerciseService;

    private final TopicService topicService;

    private final JwtTokenService jwtTokenService;

    public GetLecturesByLevelResponse getLecturesByLevel(String authorizationHeader, UUID levelId) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));
        List<LecturesByTopicDto> lecturesByTopicDtoList = topicService.getTopics().stream()
                .map(TopicMapper.INSTANCE::topicDtoToLecturesByTopicDto)
                .toList();

        for (LecturesByTopicDto lecturesByTopicDto : lecturesByTopicDtoList) {
            List<LectureStatDetailDto> lectureStatDetailDtoList = lectureRepository
                    .findAllByLevelIdAndTopicId(levelId, lecturesByTopicDto.getTopicId()).stream()
                    .map(LectureMapper.INSTANCE::lectureToLectureStatDetailDto)
                    .toList();
            lecturesByTopicDto.setLectures(lectureStatDetailDtoList);
            if (!lectureStatDetailDtoList.isEmpty()) {
                updateLectureDetailDtoList(lectureStatDetailDtoList, userId);
            }
        }
        lecturesByTopicDtoList = lecturesByTopicDtoList
                .stream().filter(lecturesByTopicDto -> !lecturesByTopicDto.getLectures().isEmpty()).toList();

        return new GetLecturesByLevelResponse(
                generalMessageAccessor.getMessage(null, "get_lectures_success"),
                lecturesByTopicDtoList.size(),
                lecturesByTopicDtoList
        );
    }

    @Override
    public GetLecturesResponse getLecturesByKeyword(String authorizationHeader, String keyword) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));

        List<Lecture> lectures = lectureRepository.findAllByNameContainingIgnoreCase(keyword);
        if (!lectures.isEmpty()) {
            List<LectureStatDetailDto> lectureStatDetailDtoList = lectures.stream()
                    .map(LectureMapper.INSTANCE::lectureToLectureStatDetailDto).toList();
            updateLectureDetailDtoList(lectureStatDetailDtoList, userId);
            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "search_lectures_success"),
                    lectureStatDetailDtoList.size(),
                    lectureStatDetailDtoList);
        }
        return new GetLecturesResponse(
                generalMessageAccessor.getMessage(null, "search_lectures_success"),
                0,
                new ArrayList<>()
        );
    }

    @Override
    public GetLecturesResponse getLecturesByRecent(String authorizationHeader, int size) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));

        List<RecentActivityDto> recentExerciseActivityList = exerciseHistoryService.getRecentActivity(userId);
        List<RecentActivityDto> recentLectureActivityList = lectureHistoryService.getRecentActivity(userId);
        List<RecentActivityDto> recentActivityDtoList = new ArrayList<>(recentExerciseActivityList);
        if (!recentLectureActivityList.isEmpty()) recentActivityDtoList.addAll(recentLectureActivityList);

        recentActivityDtoList.sort((a, b) -> b.getDate().compareTo(a.getDate()));
        Set<UUID> recentLectureId = new TreeSet<>();
        for (RecentActivityDto recentActivityDto : recentActivityDtoList) {
            if (recentLectureId.add(recentActivityDto.getLectureId())) {
                --size;
            }
            if (size == 0) {
                break;
            }
        }

        List<Lecture> lectures = lectureRepository.findAllByLectureIdList(recentLectureId.stream().toList());
        if (!lectures.isEmpty()) {
            List<LectureStatDetailDto> lectureStatDetailDtoList = lectures.stream()
                    .map(LectureMapper.INSTANCE::lectureToLectureStatDetailDto).toList();
            updateLectureDetailDtoList(lectureStatDetailDtoList, userId);
            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "get_recent_lectures_success"),
                    lectureStatDetailDtoList.size(),
                    lectureStatDetailDtoList);
        }
        return new GetLecturesResponse(
                generalMessageAccessor.getMessage(null, "get_recent_lectures_success"),
                0,
                new ArrayList<>()
        );
    }

    private void updateLectureDetailDtoList(List<LectureStatDetailDto> lectureStatDetailDtoList, UUID userId) {
        List<UUID> lectureIdList = lectureStatDetailDtoList.stream()
                .map(LectureStatDetailDto::getLectureId)
                .toList();
        Map<UUID, Integer> passExerciseTotalsMap = exerciseHistoryService
                .getPassedExerciseCountForLecturesOfUser(lectureIdList, userId);
        Map<UUID, Integer> exerciseTotalsMap = exerciseService.getExerciseCountForLectures(lectureIdList);

        for (LectureStatDetailDto lectureStatDetailDto : lectureStatDetailDtoList) {
            lectureStatDetailDto.setTotalPassExercises(
                    passExerciseTotalsMap.getOrDefault(lectureStatDetailDto.getLectureId(), 0)
            );
            lectureStatDetailDto.setTotalExercises(
                    exerciseTotalsMap.getOrDefault(lectureStatDetailDto.getLectureId(), 0)
            );
        }
    }
}
