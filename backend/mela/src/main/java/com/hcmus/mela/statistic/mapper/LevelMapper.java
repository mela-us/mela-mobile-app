package com.hcmus.mela.statistic.mapper;

import com.hcmus.mela.lecture.dto.dto.LevelDto;
import com.hcmus.mela.lecture.model.Level;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LevelMapper {

    LevelMapper INSTANCE = Mappers.getMapper(LevelMapper.class);

    LevelDto levelToLevelDto(Level level);
}
