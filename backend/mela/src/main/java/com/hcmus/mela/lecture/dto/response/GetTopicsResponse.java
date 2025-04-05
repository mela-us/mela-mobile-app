package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.TopicDto;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GetTopicsResponse {

    private String message;

    private Integer total;

    private List<TopicDto> data;
}
