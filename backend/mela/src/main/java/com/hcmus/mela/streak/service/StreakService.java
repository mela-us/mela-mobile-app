package com.hcmus.mela.streak.service;

import com.hcmus.mela.streak.dto.response.GetStreakResponse;
import com.hcmus.mela.streak.dto.response.UpdateStreakResponse;

import java.util.UUID;

public interface StreakService {

    GetStreakResponse getStreak(UUID userId);

    UpdateStreakResponse updateStreak(UUID userId);
}
