package com.hcmus.mela.statistic.dto.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SectionActivityDto {

    private String sectionName;

    private LocalDateTime date;
}
