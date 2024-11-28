package com.hcmus.mela.lecture.mapper;

import com.hcmus.mela.lecture.dto.dto.LectureInfoDto;
import com.hcmus.mela.lecture.dto.dto.LectureSectionDto;
import com.hcmus.mela.lecture.dto.dto.LectureDetailDto;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.model.LectureExerciseTotal;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LectureMapper {
    LectureMapper INSTANCE = Mappers.getMapper(LectureMapper.class);

    LectureInfoDto lectureToLectureInfoDto(Lecture lecture);

    LectureDetailDto lectureToLectureDetailDto(Lecture lecture);
}
