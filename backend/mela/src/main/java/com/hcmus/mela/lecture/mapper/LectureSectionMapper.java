package com.hcmus.mela.lecture.mapper;

import com.hcmus.mela.lecture.dto.dto.SectionDto;
import com.hcmus.mela.lecture.model.Section;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureSectionMapper {

    LectureSectionMapper INSTANCE = Mappers.getMapper(LectureSectionMapper.class);

    SectionDto lectureSectionToLectureSectionDto(Section section);
}
