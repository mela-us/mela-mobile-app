package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.LectureInfoDto;
import com.hcmus.mela.lecture.dto.dto.LectureSectionDto;
import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.mapper.LectureMapper;
import com.hcmus.mela.lecture.mapper.LectureSectionMapper;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.repository.LectureRepository;
import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class LectureDetailServiceImpl implements LectureDetailService {

    private final GeneralMessageAccessor generalMessageAccessor;

    private final LectureRepository lectureRepository;

    @Override
    public Lecture getLectureById(UUID lectureId) {
        return lectureRepository.findById(lectureId);
    }

    @Override
    public GetLectureSectionsResponse getLectureSections(UUID lectureId) {
        Lecture lecture = lectureRepository.findById(lectureId);

        LectureInfoDto lectureInfo = LectureMapper.INSTANCE.lectureToLectureInfoDto(lecture);
        List<LectureSectionDto> lectureSectionDtos = new ArrayList<>();
        lecture.getSections().forEach(section -> {
            lectureSectionDtos.add(LectureSectionMapper.INSTANCE.lectureSectionToLectureSectionDto(section));
        });
        lectureSectionDtos.sort(Comparator.comparingInt(LectureSectionDto::getOrdinalNumber));

        return new GetLectureSectionsResponse(
                generalMessageAccessor.getMessage(null, "get_sections_success"),
                lectureSectionDtos.size(),
                lectureInfo,
                lectureSectionDtos
        );
    }
}