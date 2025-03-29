package com.hcmus.mela.history.dto.dto;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class RecentActivityDto implements Serializable {
    
    private UUID lectureId;

    private LocalDateTime date;
}