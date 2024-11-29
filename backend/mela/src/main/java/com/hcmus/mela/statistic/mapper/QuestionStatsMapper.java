package com.hcmus.mela.statistic.mapper;

import com.hcmus.mela.lecture.dto.dto.LectureDetailDto;
import com.hcmus.mela.lecture.dto.dto.LectureInfoDto;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.statistic.dto.dto.QuestionStatsDto;
import com.hcmus.mela.statistic.model.QuestionStats;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface QuestionStatsMapper {
    QuestionStatsMapper INSTANCE = Mappers.getMapper(QuestionStatsMapper.class);

    QuestionStatsDto questionStatsToQuestionStatsDto(QuestionStats questionStats);
}
