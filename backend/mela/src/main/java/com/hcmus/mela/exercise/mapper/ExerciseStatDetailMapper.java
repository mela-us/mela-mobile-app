package com.hcmus.mela.exercise.mapper;

import com.hcmus.mela.exercise.dto.dto.ExerciseStatDetailDto;
import com.hcmus.mela.exercise.model.Exercise;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ExerciseStatDetailMapper {

    ExerciseStatDetailMapper INSTANCE = Mappers.getMapper(ExerciseStatDetailMapper.class);

    ExerciseStatDetailDto convertToExerciseStatDetailDto(Exercise exercise);
}
