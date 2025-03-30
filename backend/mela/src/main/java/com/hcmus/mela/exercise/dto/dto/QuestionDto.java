package com.hcmus.mela.exercise.dto.dto;

import com.hcmus.mela.exercise.model.Option;
import com.hcmus.mela.exercise.model.QuestionType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDto {

    private UUID questionId;

    private Integer ordinalNumber;

    private String content;

    private QuestionType questionType;

    private List<Option> options;

    private String blankAnswer;

    private String solution;

    private String terms;

    private String guide;
}
