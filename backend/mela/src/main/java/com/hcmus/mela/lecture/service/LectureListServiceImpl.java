package com.hcmus.mela.lecture.service;

import com.hcmus.mela.common.async.AsyncCustomService;
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

import java.util.Collections;
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

    private final AsyncCustomService asyncCustomService;

    @Override
    public GetLecturesByLevelResponse getLecturesByLevel(UUID userId, UUID levelId) {
        CompletableFuture<Map<UUID, Integer>> passExerciseTotalsMapFuture = asyncCustomService.runAsync(
                () -> exerciseHistoryService.getPassedExerciseCountOfUser(userId),
                Collections.emptyMap());
        CompletableFuture<List<LecturesByTopicDto>> lecturesByTopicDtoListFuture = asyncCustomService.runAsync(
                () -> topicService.getTopics()
                        .stream()
                        .map(TopicMapper.INSTANCE::topicDtoToLecturesByTopicDto)
                        .toList(),
                Collections.emptyList());
        Map<UUID, Integer> passMap = passExerciseTotalsMapFuture.join();
        List<LecturesByTopicDto> lecturesByTopicDtoList = lecturesByTopicDtoListFuture.join();

        for (LecturesByTopicDto lecturesByTopicDto : lecturesByTopicDtoList) {
            List<Lecture> lectures = lectureRepository.findLecturesByTopicAndLevel(lecturesByTopicDto.getTopicId(), levelId);
            if (lectures.isEmpty()) {
                lecturesByTopicDto.setLectures(Collections.emptyList());
                continue;
            }
            List<LectureStatDetailDto> lectureStatDetailDtoList = convertLecturesToLectureStatList(passMap, lectures);
            lecturesByTopicDto.setLectures(lectureStatDetailDtoList);
        }
        lecturesByTopicDtoList = lecturesByTopicDtoList
                .stream().filter(dto -> !dto.getLectures().isEmpty()).toList();

        return new GetLecturesByLevelResponse(
                generalMessageAccessor.getMessage(null, "get_lectures_success"),
                lecturesByTopicDtoList.size(),
                lecturesByTopicDtoList
        );
    }

    @Override
    public GetLecturesResponse getLecturesByKeyword(UUID userId, String keyword) {
        CompletableFuture<List<Lecture>> lecturesFuture = asyncCustomService.runAsync(
                () -> lectureRepository.findLecturesByKeyword(keyword),
                Collections.emptyList());
        CompletableFuture<Map<UUID, Integer>> passExerciseTotalsMapFuture = asyncCustomService.runAsync(
                () -> exerciseHistoryService.getPassedExerciseCountOfUser(userId),
                Collections.emptyMap());
        Map<UUID, Integer> passMap = passExerciseTotalsMapFuture.join();
        List<Lecture> lectures = lecturesFuture.join();

        if (lectures.isEmpty()) {
            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "search_lectures_success"),
                    0,
                    Collections.emptyList()
            );
        }
        return getLectureStatListResponse(passMap, lectures);
    }

    @Override
    public GetLecturesResponse getLecturesByRecent(UUID userId, Integer size) {
        List<RecentActivityDto> recentActivities = activityService.getRecentActivityOfUser(userId, size);

        if (recentActivities.isEmpty()) {
            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "get_recent_lectures_success"),
                    0,
                    Collections.emptyList()
            );
        }
        List<UUID> lectureIds = recentActivities.stream()
                .map(RecentActivityDto::getLectureId)
                .toList();

        CompletableFuture<Map<UUID, Integer>> passExerciseTotalsMapFuture = asyncCustomService.runAsync(
                () -> exerciseHistoryService.getPassedExerciseCountOfUser(userId),
                Collections.emptyMap());
        CompletableFuture<List<Lecture>> lecturesFuture = asyncCustomService.runAsync(
                () -> lectureRepository.findAllByLectureIdList(lectureIds),
                Collections.emptyList());
        Map<UUID, Integer> passMap = passExerciseTotalsMapFuture.join();
        List<Lecture> lectures = lecturesFuture.join();

        return getLectureStatListResponse(passMap, lectures);
    }

    private GetLecturesResponse getLectureStatListResponse(Map<UUID, Integer> passExerciseTotalsMap, List<Lecture> lectures) {
        List<LectureStatDetailDto> lectureStatDetailDtoList = convertLecturesToLectureStatList(passExerciseTotalsMap, lectures);
        return new GetLecturesResponse(
                "Get lectures success!",
                lectureStatDetailDtoList.size(),
                lectureStatDetailDtoList);
    }

    private List<LectureStatDetailDto> convertLecturesToLectureStatList(Map<UUID, Integer> passExerciseTotalsMap, List<Lecture> lectures) {
        return lectures.stream()
                .map(LectureMapper.INSTANCE::lectureToLectureStatDetailDto)
                .peek(dto -> dto.setTotalPassExercises(passExerciseTotalsMap.getOrDefault(dto.getLectureId(), 0)))
                .toList();
    }
}