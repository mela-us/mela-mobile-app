package com.hcmus.mela.security.mapper;

import com.hcmus.mela.dto.service.UserExerciseDto;
import com.hcmus.mela.model.mongo.UserExercise;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserExerciseMapper {
    UserExerciseMapper INSTANCE = Mappers.getMapper(UserExerciseMapper.class);

    UserExerciseDto convertToUserExerciseDto(UserExercise userExercise);
}
