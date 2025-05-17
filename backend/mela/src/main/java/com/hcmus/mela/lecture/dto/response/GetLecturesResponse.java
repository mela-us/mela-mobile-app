package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.LectureStatDetailDto;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GetLecturesResponse {

    private String message;

    private Integer total;

    private List<LectureStatDetailDto> data;
}
