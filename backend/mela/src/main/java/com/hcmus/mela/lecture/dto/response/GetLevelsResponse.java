package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.LevelDto;
import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GetLevelsResponse {

    private String message;

    private Integer total;

    private List<LevelDto> data;
}
