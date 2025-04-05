package com.hcmus.mela.history.mapper;

import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.model.ExerciseHistory;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface RecentActivityMapper {

    RecentActivityMapper INSTANCE = Mappers.getMapper(RecentActivityMapper.class);

    @Mapping(source = "completedAt", target = "date")
    RecentActivityDto convertToRecentActivityDto(ExerciseHistory exerciseHistory);
}