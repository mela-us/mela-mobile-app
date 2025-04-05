package com.hcmus.mela.history.mapper;

import com.hcmus.mela.history.dto.dto.LectureHistoryDto;
import com.hcmus.mela.history.model.LectureHistory;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = LectureCompletedSectionMapper.class)
public interface LectureHistoryMapper {

    LectureHistoryMapper INSTANCE = Mappers.getMapper(LectureHistoryMapper.class);

    @Mapping(source = "completedSections", target = "completedSections", qualifiedByName = "convertToLectureCompletedSectionDtoList")
    LectureHistoryDto converToLectureHistoryDto(LectureHistory lectureHistory);
}
