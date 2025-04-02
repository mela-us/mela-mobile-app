package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.LectureDto;
import com.hcmus.mela.lecture.dto.dto.LectureOfSectionDto;
import com.hcmus.mela.lecture.dto.dto.SectionDto;
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
public class LectureServiceImpl implements LectureService {

    private final GeneralMessageAccessor generalMessageAccessor;

    private final LectureRepository lectureRepository;

    @Override
    public LectureDto getLectureById(UUID lectureId) {
        Lecture lecture = lectureRepository.findByLectureId(lectureId);
        if (lecture == null) {
            return null;
        }
        return LectureMapper.INSTANCE.lectureToLectureDto(lecture);
    }

    @Override
    public GetLectureSectionsResponse getLectureSections(UUID lectureId) {
        Lecture lecture = lectureRepository.findByLectureId(lectureId);

        LectureOfSectionDto lectureInfo = LectureMapper.INSTANCE.lectureToLectureOfSectionDto(lecture);
        List<SectionDto> sectionDtoList = new ArrayList<>();
        lecture.getSections().forEach(section -> {
            sectionDtoList.add(LectureSectionMapper.INSTANCE.lectureSectionToLectureSectionDto(section));
        });
        sectionDtoList.sort(Comparator.comparingInt(SectionDto::getOrdinalNumber));

        return new GetLectureSectionsResponse(
                generalMessageAccessor.getMessage(null, "get_sections_success"),
                sectionDtoList.size(),
                lectureInfo,
                sectionDtoList
        );
    }
}
