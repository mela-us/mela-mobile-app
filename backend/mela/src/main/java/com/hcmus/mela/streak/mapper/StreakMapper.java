package com.hcmus.mela.streak.mapper;

import com.hcmus.mela.streak.dto.response.GetStreakResponse;
import com.hcmus.mela.streak.model.Streak;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface StreakMapper {
    StreakMapper INSTANCE = Mappers.getMapper(StreakMapper.class);

    GetStreakResponse convertToGetStreakResponse(Streak streak);
}
