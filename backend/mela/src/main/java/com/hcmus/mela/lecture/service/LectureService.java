package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.LectureContentDto;
import com.hcmus.mela.lecture.dto.LectureDto;
import com.hcmus.mela.lecture.dto.LectureStatsDto;
import com.hcmus.mela.lecture.mapper.LectureMapper;
import com.hcmus.mela.lecture.mapper.LectureStatsMapper;
import com.hcmus.mela.lecture.repository.LectureRepositoryImpl;
import com.hcmus.mela.lecture.repository.LectureStatsRepositoryImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LectureService {
    private final LectureRepositoryImpl lectureRepository;

    private final LectureStatsRepositoryImpl lectureStatsRepository;

    public LectureContentDto getLectureContent(Integer lectureId) {
           return LectureMapper.INSTANCE.lectureToLectureContentDto(
                   lectureRepository.findByLectureId(lectureId).getLectureContent()
           );
    }

    public List<LectureDto> getLeturesByFilters(Integer topicId, Integer levelId, String keyword) {
        return lectureRepository.findLecturesByFilters(topicId, levelId, keyword).stream().map(
                LectureMapper.INSTANCE::lectureToLectureDto
        ).collect(Collectors.toList());
    }

    public List<LectureStatsDto> getLectureStatsLists() {
        Integer userId = 25;
        return lectureStatsRepository.findLectureStatsListByUserId(userId).stream().map(
                LectureStatsMapper.INSTANCE::lectureStatsToLectureStatsDto
        ).collect(Collectors.toList());
    }

}