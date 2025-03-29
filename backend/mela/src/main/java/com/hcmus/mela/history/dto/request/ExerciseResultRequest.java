package com.hcmus.mela.history.dto.request;

import com.hcmus.mela.history.dto.dto.ExerciseAnswerDto;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ExerciseResultRequest {

    private UUID exerciseId;

    private LocalDateTime startedAt;

    private LocalDateTime completedAt;

    private List<ExerciseAnswerDto> answers;
}
