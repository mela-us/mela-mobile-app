package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.LectureInfoDto;
import com.hcmus.mela.lecture.dto.dto.LectureSectionDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GetLectureSectionsResponse {

    private String message;

    private Integer total;

    private LectureInfoDto lecture;

    private List<LectureSectionDto> data;
}

