package com.hcmus.mela.dto.response;

import com.hcmus.mela.model.mongo.Exercise;

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
    private List<Exercise> exercises;
}
