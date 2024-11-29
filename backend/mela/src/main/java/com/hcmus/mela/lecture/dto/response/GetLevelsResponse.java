package com.hcmus.mela.lecture.dto.response;

import com.hcmus.mela.lecture.dto.dto.LevelDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GetLevelsResponse {

    private String message;

    private Integer total;
    
    private List<LevelDto> data;
}
