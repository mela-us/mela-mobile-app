package com.hcmus.mela.dto.response;

import com.hcmus.mela.dto.service.QuestionDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuestionResponse {

    private String message;

    private List<QuestionDto> questions;
}
