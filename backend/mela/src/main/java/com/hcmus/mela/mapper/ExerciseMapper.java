package com.hcmus.mela.mapper;

import com.hcmus.mela.dto.service.ExerciseDto;
import com.hcmus.mela.dto.service.LectureContentDto;
import com.hcmus.mela.dto.service.LectureDto;
import com.hcmus.mela.model.mongo.Exercise;
import com.hcmus.mela.model.mongo.Lecture;
import com.hcmus.mela.model.mongo.LectureContent;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ExerciseMapper {
    ExerciseMapper INSTANCE = Mappers.getMapper(ExerciseMapper.class);

    ExerciseDto exerciseToExerciseDto(Exercise exercise);
}
