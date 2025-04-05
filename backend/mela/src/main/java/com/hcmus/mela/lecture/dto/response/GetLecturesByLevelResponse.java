package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.LecturesByTopicDto;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GetLecturesByLevelResponse {

    private String message;

    private Integer total;

    private List<LecturesByTopicDto> data;
}
