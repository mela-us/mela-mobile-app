package com.hcmus.mela.lecture.mapper;

import com.hcmus.mela.lecture.dto.LectureContentDto;
import com.hcmus.mela.lecture.dto.LectureDto;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.model.LectureContent;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureMapper {
    LectureMapper INSTANCE = Mappers.getMapper(LectureMapper.class);

    LectureDto lectureToLectureDto(Lecture lecture);
    LectureContentDto lectureToLectureContentDto(LectureContent lectureContent);
}
