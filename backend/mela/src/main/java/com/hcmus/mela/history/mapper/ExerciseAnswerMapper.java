package com.hcmus.mela.history.mapper;

import com.hcmus.mela.exercise.dto.dto.QuestionDto;
import com.hcmus.mela.exercise.model.Question;
import com.hcmus.mela.history.dto.dto.ExerciseAnswerDto;
import com.hcmus.mela.history.model.ExerciseAnswer;
import org.mapstruct.Mapper;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ExerciseAnswerMapper {

    ExerciseAnswerMapper INSTANCE = Mappers.getMapper(ExerciseAnswerMapper.class);

    ExerciseAnswerDto convertToExerciseAnswerDto(ExerciseAnswer answer);

    @Named("convertToExerciseAnswerDtoList")
    List<ExerciseAnswerDto> convertToExerciseAnswerDtoList(List<ExerciseAnswer> answers);
}
