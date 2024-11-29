package com.hcmus.mela.lecture.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.lecture.dto.dto.LectureDetailDto;
import com.hcmus.mela.lecture.dto.dto.LectureInfoDto;
import com.hcmus.mela.lecture.dto.dto.LectureSectionDto;
import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;
import com.hcmus.mela.lecture.mapper.LectureMapper;
import com.hcmus.mela.lecture.mapper.LectureSectionMapper;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.model.LectureExerciseTotal;
import com.hcmus.mela.lecture.repository.ExerciseCountRepositoryImpl;
import com.hcmus.mela.lecture.repository.LectureRepositoryImpl;
import com.hcmus.mela.utils.ExceptionMessageAccessor;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LectureServiceImpl implements LectureService {

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final LectureRepositoryImpl lectureRepository;

    private final ExerciseCountRepositoryImpl exerciseCountRepository;

    private final JwtTokenService jwtTokenService;

    @Override
    public GetLecturesResponse getLecturesByTopic(String authorizationHeader, UUID topicId) {
        UUID userId = jwtTokenService.getUserIdFromToken(jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));

        List<Lecture> lectures = lectureRepository.findLecturesByTopic(topicId);
        List<LectureExerciseTotal> exerciseTotals = exerciseCountRepository.countTotalExerciseOfLectures();
        List<LectureExerciseTotal> passExerciseTotals = exerciseCountRepository.countTotalPassExerciseOfLectures(userId);

        List<LectureDetailDto> lectureDetailDtos = convertLecturesToLectureDetailDtos(lectures, exerciseTotals, passExerciseTotals);

        return new GetLecturesResponse(
                generalMessageAccessor.getMessage(null, "get_lectures_success"),
                lectureDetailDtos.size(),
                lectureDetailDtos
        );
    }

    @Override
    public GetLecturesResponse getLecturesByKeyword(String authorizationHeader, String keyword) {
        UUID userId = jwtTokenService.getUserIdFromToken(jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));

        List<Lecture> lectures = lectureRepository.findLecturesByKeyword(keyword);
        List<LectureExerciseTotal> exerciseTotals = exerciseCountRepository.countTotalExerciseOfLectures();
        List<LectureExerciseTotal> passExerciseTotals = exerciseCountRepository.countTotalPassExerciseOfLectures(userId);

        List<LectureDetailDto> lectureDetailDtos = convertLecturesToLectureDetailDtos(lectures, exerciseTotals, passExerciseTotals);

        return new GetLecturesResponse(
                generalMessageAccessor.getMessage(null, "search_lectures_success"),
                lectureDetailDtos.size(),
                lectureDetailDtos
        );
    }

    @Override
    public GetLecturesResponse getLecturesByRecent(String authorizationHeader, Integer size) {
        UUID userId = jwtTokenService.getUserIdFromToken(jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));

        List<Lecture> lectures = lectureRepository.findLectureByRecent(size);
        List<LectureExerciseTotal> exerciseTotals = exerciseCountRepository.countTotalExerciseOfLectures();
        List<LectureExerciseTotal> passExerciseTotals = exerciseCountRepository.countTotalPassExerciseOfLectures(userId);

        List<LectureDetailDto> lectureDetailDtos = convertLecturesToLectureDetailDtos(lectures, exerciseTotals, passExerciseTotals);

        return new GetLecturesResponse(
                generalMessageAccessor.getMessage(null, "get_recent_lectures_success"),
                lectureDetailDtos.size(),
                lectureDetailDtos
        );
    }

    @Override
    public GetLectureSectionsResponse getLectureSections(UUID lectureId) {
        Lecture lecture = lectureRepository.findLectureSectionsByLecture(lectureId);

        LectureInfoDto lectureInfo = LectureMapper.INSTANCE.lectureToLectureInfoDto(lecture);
        List<LectureSectionDto> lectureSectionDtos = new ArrayList<LectureSectionDto>();
        lecture.getSections().stream().forEach(section -> {
            lectureSectionDtos.add(LectureSectionMapper.INSTANCE.lectureSectionToLectureSectionDto(section));
        });

        return new GetLectureSectionsResponse(
                generalMessageAccessor.getMessage(null, "get_sections_success"),
                lectureSectionDtos.size(),
                lectureInfo,
                lectureSectionDtos
        );
    }

    public List<LectureDetailDto> convertLecturesToLectureDetailDtos(
            List<Lecture> lectures,
            List<LectureExerciseTotal> exerciseTotals,
            List<LectureExerciseTotal> passExerciseTotals
    ) {
        Map<UUID, Integer> exerciseTotalsMap = exerciseTotals.stream()
                .collect(Collectors.toMap(LectureExerciseTotal::getLectureId, LectureExerciseTotal::getTotal));

        Map<UUID, Integer> passExerciseTotalsMap = passExerciseTotals.stream()
                .collect(Collectors.toMap(LectureExerciseTotal::getLectureId, LectureExerciseTotal::getTotal));

        List<LectureDetailDto> lectureDetailDtos = new ArrayList<>();

        for (Lecture lecture : lectures) {
            LectureDetailDto lectureDetailDto = LectureMapper.INSTANCE.lectureToLectureDetailDto(lecture);

            // Get total exercises from the map, default to 0 if not found
            Integer totalExercises = exerciseTotalsMap.getOrDefault(lecture.getLectureId(), 0);
            lectureDetailDto.setTotalExercises(totalExercises);

            // Get total passed exercises from the map, default to 0 if not found
            Integer totalPassExercises = passExerciseTotalsMap.getOrDefault(lecture.getLectureId(), 0);
            lectureDetailDto.setTotalPassExercises(totalPassExercises);

            lectureDetailDtos.add(lectureDetailDto);
        }
        return lectureDetailDtos;
    }
}