package com.hcmus.mela.security.mapper;

import com.hcmus.mela.dto.service.QuestionDto;
import com.hcmus.mela.model.mongo.Question;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface QuestionMapper {

    QuestionMapper INSTANCE = Mappers.getMapper(QuestionMapper.class);

    QuestionDto convertToQuestionDto(Question question);
}
