package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.ExerciseDto;
import com.hcmus.mela.dto.service.LectureContentDto;
import com.hcmus.mela.dto.service.LectureDto;
import com.hcmus.mela.dto.service.LectureStatsDto;
import com.hcmus.mela.mapper.ExerciseMapper;
import com.hcmus.mela.mapper.LectureMapper;
import com.hcmus.mela.mapper.LectureStatsMapper;
import com.hcmus.mela.repository.mongo.ExerciseRepositoryImpl;
import com.hcmus.mela.repository.mongo.LectureRepositoryImpl;
import com.hcmus.mela.repository.mongo.LectureStatsRepositoryImpl;
import com.hcmus.mela.security.service.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PracticeService {
    private final ExerciseRepositoryImpl exerciseRepository;

    public List<ExerciseDto> getExercisesByLectureId(Integer lectureId) {
           return exerciseRepository.findExercisesByLectureId(lectureId).stream().map(
                   ExerciseMapper.INSTANCE::exerciseToExerciseDto
           ).collect(Collectors.toList());
    }
}