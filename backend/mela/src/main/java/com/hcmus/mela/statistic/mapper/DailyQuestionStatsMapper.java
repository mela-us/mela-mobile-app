package com.hcmus.mela.statistic.mapper;

import com.hcmus.mela.lecture.dto.dto.LectureSectionDto;
import com.hcmus.mela.lecture.model.LectureSection;
import com.hcmus.mela.statistic.dto.dto.DailyQuestionStatsDto;
import com.hcmus.mela.statistic.model.DailyQuestionStats;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface DailyQuestionStatsMapper {
    DailyQuestionStatsMapper INSTANCE = Mappers.getMapper(DailyQuestionStatsMapper.class);

    DailyQuestionStatsDto dailyQuestionStatsToDailyQuestionStatsDto(DailyQuestionStats dailyQuestionStats);
}
