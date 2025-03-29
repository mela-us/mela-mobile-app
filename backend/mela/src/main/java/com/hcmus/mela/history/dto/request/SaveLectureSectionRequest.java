package com.hcmus.mela.history.dto.request;

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

    private UUID lectureId;

    private Integer ordinalNumber;

    private LocalDateTime completedAt;
}
