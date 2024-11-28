package com.hcmus.mela.statistic.dto.dto;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LevelDto {
    private UUID levelId;
    private String name;
}
