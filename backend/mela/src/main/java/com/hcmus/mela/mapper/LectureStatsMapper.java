package com.hcmus.mela.mapper;

import com.hcmus.mela.dto.service.LectureContentDto;
import com.hcmus.mela.dto.service.LectureDto;
import com.hcmus.mela.dto.service.LectureStatsDto;
import com.hcmus.mela.model.mongo.Lecture;
import com.hcmus.mela.model.mongo.LectureContent;
import com.hcmus.mela.model.mongo.LectureStats;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureStatsMapper {
    LectureStatsMapper INSTANCE = Mappers.getMapper(LectureStatsMapper.class);

    LectureStatsDto lectureStatsToLectureStatsDto(LectureStats lectureStats);
}
