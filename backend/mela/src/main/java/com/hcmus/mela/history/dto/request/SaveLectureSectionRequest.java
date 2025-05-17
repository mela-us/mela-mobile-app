package com.hcmus.mela.history.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SaveLectureSectionRequest {

    @Schema(description = "Id of the lecture", example = "344069af-a408-4b27-917a-ea49b7a14e33")
    private UUID lectureId;

    @Schema(description = "Ordinal number of the section", example = "1")
    private Integer ordinalNumber;

    @Schema(description = "Complete time of the section", example = "2025-04-02T00:05:00")
    private LocalDateTime completedAt;
}
