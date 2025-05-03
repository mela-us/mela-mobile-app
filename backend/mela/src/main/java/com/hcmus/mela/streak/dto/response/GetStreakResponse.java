package com.hcmus.mela.streak.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
public class GetStreakResponse {

    private Integer streakDays;

    private Date updatedAt;

    private Integer longestStreak;

    private String message;
}
