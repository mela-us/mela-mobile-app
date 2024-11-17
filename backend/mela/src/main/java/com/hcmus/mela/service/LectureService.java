package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.*;
import com.hcmus.mela.mapper.LectureMapper;
import com.hcmus.mela.mapper.LectureStatsMapper;
import com.hcmus.mela.repository.mongo.LectureRepositoryImpl;
import com.hcmus.mela.repository.mongo.LectureStatsRepositoryImpl;
import com.hcmus.mela.security.service.UserServiceImpl;
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