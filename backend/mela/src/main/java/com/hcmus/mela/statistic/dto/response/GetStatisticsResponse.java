package com.hcmus.mela.statistic.dto.response;

import com.hcmus.mela.statistic.dto.dto.ActivityHistoryDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GetStatisticsResponse {

    private String message;

    private Integer total;

    private List<ActivityHistoryDto> data;
}

