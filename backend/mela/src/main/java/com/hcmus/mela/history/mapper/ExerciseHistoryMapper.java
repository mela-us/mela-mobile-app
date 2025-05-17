package com.hcmus.mela.history.mapper;

import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.model.ExerciseHistory;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = ExerciseAnswerMapper.class)
public interface ExerciseHistoryMapper {

    ExerciseHistoryMapper INSTANCE = Mappers.getMapper(ExerciseHistoryMapper.class);

    @Mapping(source = "answers", target = "answers", qualifiedByName = "convertToExerciseAnswerDtoList")
    ExerciseHistoryDto converToExerciseHistoryDto(ExerciseHistory exerciseHistory);
}
