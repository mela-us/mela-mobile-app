package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
@Getter
public class RecentActivityDto {

    private UUID lectureId;

    private LocalDateTime date;
}