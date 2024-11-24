package com.hcmus.mela.exercise.mapper;

import com.hcmus.mela.exercise.dto.dto.UserExerciseDto;
import com.hcmus.mela.exercise.model.UserExercise;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserExerciseMapper {
    UserExerciseMapper INSTANCE = Mappers.getMapper(UserExerciseMapper.class);

    UserExerciseDto convertToUserExerciseDto(UserExercise userExercise);
}
