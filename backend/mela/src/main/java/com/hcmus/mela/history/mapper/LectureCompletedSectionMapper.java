package com.hcmus.mela.history.mapper;

import com.hcmus.mela.history.dto.dto.LectureCompletedSectionDto;
import com.hcmus.mela.history.model.ExerciseAnswer;
import com.hcmus.mela.history.model.LectureCompletedSection;
import org.mapstruct.Mapper;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureCompletedSectionMapper {

    LectureCompletedSectionMapper INSTANCE = Mappers.getMapper(LectureCompletedSectionMapper.class);

    LectureCompletedSectionDto convertToLectureCompletedSectionDto(LectureCompletedSection section);

    @Named("convertToLectureCompletedSectionDtoList")
    List<LectureCompletedSectionDto> convertToLectureCompletedSectionDtoList(List<LectureCompletedSection> sections);
}
