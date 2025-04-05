package com.hcmus.mela.exercise.mapper;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.model.ExerciseResult;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ExerciseResultMapper {

    ExerciseResultMapper INSTANCE = Mappers.getMapper(ExerciseResultMapper.class);

    ExerciseResultDto convertToExerciseResultDto(ExerciseResult exerciseResult);
}
