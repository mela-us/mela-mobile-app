package com.hcmus.mela.lecture.dto.dto;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LecturesByTopicDto {

    private UUID topicId;

    private String topicName;

    private List<LectureStatDetailDto> lectures;
}
