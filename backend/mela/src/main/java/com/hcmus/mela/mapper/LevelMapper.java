package com.hcmus.mela.mapper;

import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.model.mongo.Level;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LevelMapper {
    LevelMapper INSTANCE = Mappers.getMapper(LevelMapper.class);

    LevelDto levelToLevelDto(Level level);
}
