package com.hcmus.mela.exercise.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDto {

    private Integer questionId;

    private Integer exerciseId;

    private Integer questionNumber;

    private String questionType;

    private List<String> choices;

    private List<String> question;

    private List<String> answer;
}
