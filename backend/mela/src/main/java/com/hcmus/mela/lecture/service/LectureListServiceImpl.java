package com.hcmus.mela.lecture.service;

import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.service.ActivityService;
import com.hcmus.mela.history.service.ExerciseHistoryService;
import com.hcmus.mela.lecture.dto.dto.LectureStatDetailDto;
import com.hcmus.mela.lecture.dto.dto.LecturesByTopicDto;
import com.hcmus.mela.lecture.dto.response.GetLecturesByLevelResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;
import com.hcmus.mela.lecture.mapper.LectureMapper;
import com.hcmus.mela.lecture.mapper.TopicMapper;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.repository.LectureRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class LectureListServiceImpl implements LectureListService {

    private final GeneralMessageAccessor generalMessageAccessor;

    private final TopicService topicService;

    private final LectureRepository lectureRepository;

    private final ExerciseHistoryService exerciseHistoryService;

    private final ActivityService activityService;

    @Override
    public GetLecturesByLevelResponse getLecturesByLevel(UUID userId, UUID levelId) {
        CompletableFuture<Map<UUID, Integer>> passExerciseTotalsMapFuture = CompletableFuture.supplyAsync(() ->
                exerciseHistoryService.getPassedExerciseCountOfUser(userId));

        CompletableFuture<List<LecturesByTopicDto>> lecturesByTopicDtoListFuture = CompletableFuture.supplyAsync(() ->
                topicService.getTopics().stream()
                        .map(TopicMapper.INSTANCE::topicDtoToLecturesByTopicDto)
                        .toList());

        CompletableFuture.allOf(passExerciseTotalsMapFuture, lecturesByTopicDtoListFuture).join();

        Map<UUID, Integer> passExerciseTotalsMap = passExerciseTotalsMapFuture.join();
        List<LecturesByTopicDto> lecturesByTopicDtoList = lecturesByTopicDtoListFuture.join();

        for (LecturesByTopicDto lecturesByTopicDto : lecturesByTopicDtoList) {
            List<Lecture> lectures = lectureRepository.findLecturesByTopicAndLevel(lecturesByTopicDto.getTopicId(), levelId);
            if (lectures.isEmpty()) {
                lecturesByTopicDto.setLectures(List.of());
                continue;
            }
            List<LectureStatDetailDto> lectureStatDetailDtoList = lectures.stream()
                    .map(LectureMapper.INSTANCE::lectureToLectureStatDetailDto)
                    .toList();
            lecturesByTopicDto.setLectures(lectureStatDetailDtoList);
            for (LectureStatDetailDto lectureStatDetailDto : lecturesByTopicDto.getLectures()) {
                lectureStatDetailDto.setTotalPassExercises(
                        passExerciseTotalsMap.getOrDefault(lectureStatDetailDto.getLectureId(), 0));
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
    public GetLecturesResponse getLecturesByKeyword(UUID userId, String keyword) {
        CompletableFuture<List<Lecture>> lecturesFuture = CompletableFuture.supplyAsync(() ->
                lectureRepository.findLecturesByKeyword(keyword));
        CompletableFuture<Map<UUID, Integer>> passExerciseTotalsMapFuture = CompletableFuture.supplyAsync(() ->
                exerciseHistoryService.getPassedExerciseCountOfUser(userId));
        CompletableFuture.allOf(passExerciseTotalsMapFuture, lecturesFuture).join();
        Map<UUID, Integer> passExerciseTotalsMap = passExerciseTotalsMapFuture.join();
        List<Lecture> lectures = lecturesFuture.join();

        if (!lectures.isEmpty()) {
            return returnGetLecturesResponse(passExerciseTotalsMap, lectures);
        }
        return new GetLecturesResponse(
                generalMessageAccessor.getMessage(null, "search_lectures_success"),
                0,
                new ArrayList<>()
        );
    }

    @Override
    public GetLecturesResponse getLecturesByRecent(UUID userId, Integer size) {
        List<RecentActivityDto> recentActivityDtoList = activityService.getRecentActivityOfUser(userId, size);

        if (recentActivityDtoList.isEmpty()) {
            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "get_recent_lectures_success"),
                    0,
                    new ArrayList<>()
            );
        }

        CompletableFuture<Map<UUID, Integer>> passExerciseTotalsMapFuture = CompletableFuture.supplyAsync(() ->
                exerciseHistoryService.getPassedExerciseCountOfUser(userId));
        CompletableFuture<List<Lecture>> lecturesFuture = CompletableFuture.supplyAsync(() ->
                lectureRepository.findAllByLectureIdList(recentActivityDtoList.stream()
                        .map(RecentActivityDto::getLectureId)
                        .toList()));
        CompletableFuture.allOf(passExerciseTotalsMapFuture, lecturesFuture).join();
        Map<UUID, Integer> passExerciseTotalsMap = passExerciseTotalsMapFuture.join();
        List<Lecture> lectures = lecturesFuture.join();

        return returnGetLecturesResponse(passExerciseTotalsMap, lectures);
    }

    private GetLecturesResponse returnGetLecturesResponse(Map<UUID, Integer> passExerciseTotalsMap, List<Lecture> lectures) {
        List<LectureStatDetailDto> lectureStatDetailDtoList = lectures.stream()
                .map(LectureMapper.INSTANCE::lectureToLectureStatDetailDto).toList();
        for (LectureStatDetailDto lectureStatDetailDto : lectureStatDetailDtoList) {
            lectureStatDetailDto.setTotalPassExercises(
                    passExerciseTotalsMap.getOrDefault(lectureStatDetailDto.getLectureId(), 0));
        }
        return new GetLecturesResponse(
                "Get lectures success!",
                lectureStatDetailDtoList.size(),
                lectureStatDetailDtoList);
    }
}