package com.hcmus.mela.mapper;

import com.hcmus.mela.dto.service.LectureContentDto;
import com.hcmus.mela.dto.service.LectureDto;
import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.model.mongo.Lecture;
import com.hcmus.mela.model.mongo.LectureContent;
import com.hcmus.mela.model.mongo.Level;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureMapper {
    LectureMapper INSTANCE = Mappers.getMapper(LectureMapper.class);

    LectureDto lectureToLectureDto(Lecture lecture);
    LectureContentDto lectureToLectureContentDto(LectureContent lectureContent);
}
