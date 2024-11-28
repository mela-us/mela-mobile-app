package com.hcmus.mela.lecture.mapper;

import com.hcmus.mela.lecture.dto.dto.LectureStatsDto;
import com.hcmus.mela.lecture.model.LectureStats;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureStatsMapper {
    LectureStatsMapper INSTANCE = Mappers.getMapper(LectureStatsMapper.class);

    LectureStatsDto lectureStatsToLectureStatsDto(LectureStats lectureStats);
}
