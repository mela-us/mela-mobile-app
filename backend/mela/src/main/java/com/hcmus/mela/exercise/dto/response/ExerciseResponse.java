package com.hcmus.mela.exercise.dto.response;

import com.hcmus.mela.exercise.dto.dto.ExerciseStatDetailDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseResponse {

    private String message;

    private Integer total;

    private List<ExerciseStatDetailDto> exercises;
}
