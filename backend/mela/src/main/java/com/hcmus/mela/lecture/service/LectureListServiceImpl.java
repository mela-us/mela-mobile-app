package com.hcmus.mela.lecture.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.exercise.model.ExerciseResultCount;
import com.hcmus.mela.exercise.service.ExerciseResultService;
import com.hcmus.mela.lecture.dto.dto.LectureDetailDto;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;
import com.hcmus.mela.lecture.exception.exception.AsyncException;
import com.hcmus.mela.lecture.mapper.LectureMapper;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.repository.LectureRepository;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LectureListServiceImpl implements LectureListService {

    private final GeneralMessageAccessor generalMessageAccessor;

    private final LectureRepository lectureRepository;

    private final ExerciseResultService exerciseResultService;

    private final JwtTokenService jwtTokenService;

    @Override
    public GetLecturesResponse getLecturesByTopic(String authorizationHeader, UUID topicId) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader)
        );

        CompletableFuture<List<Lecture>> getLectureTask = CompletableFuture.supplyAsync(() -> {
            return lectureRepository.findLecturesByTopic(topicId);
        });
        CompletableFuture<List<ExerciseResultCount>> getTotalPassExerciseTask = CompletableFuture.supplyAsync(() -> {
            return exerciseResultService.countTotalPassExerciseOfLectures(userId);
        });
        CompletableFuture<Void> allOf = CompletableFuture.allOf(getLectureTask, getTotalPassExerciseTask);
        allOf.join();

        try {
            List<Lecture> lectures = getLectureTask.get();
            List<ExerciseResultCount> passExerciseTotals = getTotalPassExerciseTask.get();

            List<LectureDetailDto> lectureDetailDtos = convertLecturesToLectureDetailDtos(
                    lectures,
                    passExerciseTotals
            );

            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "get_lectures_success"),
                    lectureDetailDtos.size(),
                    lectureDetailDtos
            );
        } catch (InterruptedException | ExecutionException e) {
            throw new AsyncException(e.getMessage());
        }
    }

    @Override
    public GetLecturesResponse getLecturesByKeyword(String authorizationHeader, String keyword) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader)
        );

        CompletableFuture<List<Lecture>> getLectureTask = CompletableFuture.supplyAsync(() -> {
            return lectureRepository.findLecturesByKeyword(keyword);
        });
        CompletableFuture<List<ExerciseResultCount>> getTotalPassExerciseTask = CompletableFuture.supplyAsync(() -> {
            return exerciseResultService.countTotalPassExerciseOfLectures(userId);
        });
        CompletableFuture<Void> allOf = CompletableFuture.allOf(getLectureTask, getTotalPassExerciseTask);
        allOf.join();

        try {
            List<Lecture> lectures = getLectureTask.get();
            List<ExerciseResultCount> passExerciseTotals = getTotalPassExerciseTask.get();

            List<LectureDetailDto> lectureDetailDtos = convertLecturesToLectureDetailDtos(
                    lectures,
                    passExerciseTotals
            );

            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "search_lectures_success"),
                    lectureDetailDtos.size(),
                    lectureDetailDtos
            );
        } catch (InterruptedException | ExecutionException e) {
            throw new AsyncException(e.getMessage());
        }
    }

    @Override
    public GetLecturesResponse getLecturesByRecent(String authorizationHeader, Integer size) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader)
        );

        CompletableFuture<List<Lecture>> getLectureTask = CompletableFuture.supplyAsync(() -> {
            return lectureRepository.findLectureByRecent(size);
        });
        CompletableFuture<List<ExerciseResultCount>> getTotalPassExerciseTask = CompletableFuture.supplyAsync(() -> {
            return exerciseResultService.countTotalPassExerciseOfLectures(userId);
        });
        CompletableFuture<Void> allOf = CompletableFuture.allOf(getLectureTask, getTotalPassExerciseTask);
        allOf.join();

        try {
            List<Lecture> lectures = getLectureTask.get();
            List<ExerciseResultCount> passExerciseTotals = getTotalPassExerciseTask.get();

            List<LectureDetailDto> lectureDetailDtos = convertLecturesToLectureDetailDtos(
                    lectures,
                    passExerciseTotals
            );

            return new GetLecturesResponse(
                    generalMessageAccessor.getMessage(null, "get_recent_lectures_success"),
                    lectureDetailDtos.size(),
                    lectureDetailDtos
            );
        } catch (InterruptedException | ExecutionException e) {
            throw new AsyncException(e.getMessage());
        }
    }

    public List<LectureDetailDto> convertLecturesToLectureDetailDtos(
            List<Lecture> lectures,
            List<ExerciseResultCount> passExerciseTotals
    ) {
        Map<UUID, Integer> passExerciseTotalsMap = passExerciseTotals.stream()
                .collect(Collectors.toMap(ExerciseResultCount::getLectureId, ExerciseResultCount::getTotal));

        List<LectureDetailDto> lectureDetailDtos = new ArrayList<>();

        for (Lecture lecture : lectures) {
            LectureDetailDto lectureDetailDto = LectureMapper.INSTANCE.lectureToLectureDetailDto(lecture);

            Integer totalPassExercises = passExerciseTotalsMap.getOrDefault(lecture.getLectureId(), 0);
            lectureDetailDto.setTotalPassExercises(totalPassExercises);

            lectureDetailDtos.add(lectureDetailDto);
        }
        return lectureDetailDtos;
    }
}