package com.hcmus.mela.history.dto.response;

import com.hcmus.mela.history.dto.dto.CheckedAnswerDto;
import com.hcmus.mela.history.dto.dto.ExerciseAnswerDto;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExerciseResultResponse {

    private String message;
}
