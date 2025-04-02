package com.hcmus.mela.history.dto.request;

import com.hcmus.mela.history.dto.dto.ExerciseAnswerDto;
import io.swagger.v3.oas.annotations.media.Schema;
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

    @Schema(description = "Id of the exercise", example = "904553a4-186e-4889-bb5f-19de4c64522d")
    private UUID exerciseId;

    @Schema(description = "Start time of the exercise", example = "2025-04-02T00:00:00")
    private LocalDateTime startedAt;

    @Schema(description = "End time of the exercise", example = "2025-04-02T00:01:00")
    private LocalDateTime completedAt;

    @Schema(description = "List of answers")
    private List<ExerciseAnswerDto> answers;
}
