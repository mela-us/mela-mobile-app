package com.hcmus.mela.exercise.mapper;

import com.hcmus.mela.exercise.dto.dto.QuestionDto;
import com.hcmus.mela.exercise.model.Question;
import org.mapstruct.Mapper;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface QuestionMapper {

    QuestionMapper INSTANCE = Mappers.getMapper(QuestionMapper.class);

    QuestionDto convertToQuestionDto(Question question);

    @Named("convertToQuestionDtoList")
    List<QuestionDto> convertToQuestionDtoList(List<Question> questions);
}
