package com.hcmus.mela.security.mapper;

import com.hcmus.mela.dto.service.ExerciseDto;
import com.hcmus.mela.model.mongo.Exercise;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ExerciseMapper {

    ExerciseMapper INSTANCE = Mappers.getMapper(ExerciseMapper.class);

    ExerciseDto convertToExerciseDto(Exercise exercise);
}
