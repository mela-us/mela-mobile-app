package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.LectureStatDetailDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GetLecturesResponse {

    private String message;

    private Integer total;

    private List<LectureStatDetailDto> data;
}
