package com.hcmus.mela.lecture.mapper;

import com.hcmus.mela.lecture.dto.dto.LectureSectionDto;
import com.hcmus.mela.lecture.model.LectureSection;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureSectionMapper {
    LectureSectionMapper INSTANCE = Mappers.getMapper(LectureSectionMapper.class);

    LectureSectionDto lectureSectionToLectureSectionDto(LectureSection lectureSection);
}
