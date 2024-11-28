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
        List<LectureDetailDto> lecturDetaileDtos = new ArrayList<>();
        lectures.forEach(lecture -> {
            LectureDetailDto lectureDetailDto = LectureMapper.INSTANCE.lectureToLectureDetailDto((lecture));
            LectureExerciseTotal lectureExerciseTotal = exerciseTotals.stream()
                    .filter(e -> e.getLectureId().equals(lecture.getLectureId()))
                    .findFirst().orElse(null);
            lectureDetailDto.setTotalExercises(lectureExerciseTotal != null ? lectureExerciseTotal.getTotal() : 0);
            LectureExerciseTotal lecturePassExerciseTotal = passExerciseTotals.stream()
                    .filter(e -> e.getLectureId().equals(lecture.getLectureId()))
                    .findFirst().orElse(null);
            lectureDetailDto.setTotalPassExercises(lectureExerciseTotal != null ? lectureExerciseTotal.getTotal() : 0);
            lecturDetaileDtos.add(lectureDetailDto);
        });
        return lecturDetaileDtos;
    }
}