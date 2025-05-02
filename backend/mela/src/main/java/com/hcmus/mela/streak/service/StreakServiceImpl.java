package com.hcmus.mela.streak.service;

import com.hcmus.mela.common.exception.BadRequestException;
import com.hcmus.mela.common.utils.ExceptionMessageAccessor;
import com.hcmus.mela.common.utils.GeneralMessageAccessor;
import com.hcmus.mela.streak.dto.response.GetStreakResponse;
import com.hcmus.mela.streak.dto.response.UpdateStreakResponse;
import com.hcmus.mela.streak.model.Streak;
import com.hcmus.mela.streak.repository.StreakCustomRepository;
import com.hcmus.mela.streak.repository.StreakRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class StreakServiceImpl implements StreakService {

    private static final String STREAK_FOUND = "streak_found_successful";

    private static final String UPDATE_STREAK_SUCCESS = "update_streak_successful";

    private static final String USER_NOT_FOUND = "user_not_found";

    private final StreakRepository streakRepository;

    private final GeneralMessageAccessor generalMessageAccessor;

    private final ExceptionMessageAccessor exceptionMessageAccessor;

    @Override
    public GetStreakResponse getStreak(UUID userId) {

        Streak streak = streakRepository.findByUserId(userId);

        if (streak == null) {
            final String userNotFound = exceptionMessageAccessor.getMessage(null, USER_NOT_FOUND);
            throw new BadRequestException(userNotFound);
        }

        if (ChronoUnit.DAYS.between(
                streak.getUpdatedAt().toInstant().atZone(ZoneId.systemDefault()).toLocalDate(),
                (new Date()).toInstant().atZone(ZoneId.systemDefault()).toLocalDate()) > 1) {

            streak.setStreakDays(0);
            streak.setUpdatedAt(new Date());
            streak.setStartedAt(new Date());
            streakRepository.updateStreak(streak);
        }

        final String getStreakSuccessMessage = generalMessageAccessor.getMessage(null, STREAK_FOUND, userId);

        log.info(getStreakSuccessMessage);

        return new GetStreakResponse(streak.getStreakDays(),
                streak.getUpdatedAt(),
                streak.getLongestStreak(),
                getStreakSuccessMessage);
    }

    @Override
    public UpdateStreakResponse updateStreak(UUID userId) {
        Streak streak = streakRepository.findByUserId(userId);

        if (streak == null) {
            final String userNotFound = exceptionMessageAccessor.getMessage(null, "user_not_found");
            throw new BadRequestException(userNotFound);
        }

        streak.setStreakDays(streak.getStreakDays() + 1);

        streak.setUpdatedAt(new Date());

        if (streak.getStreakDays().compareTo(streak.getLongestStreak()) > 0) {
            streak.setLongestStreak(streak.getStreakDays() + 1);
        }

        streakRepository.updateStreak(streak);

        final String updateStreakSuccessMessage = generalMessageAccessor.getMessage(null, UPDATE_STREAK_SUCCESS, userId);

        log.info(updateStreakSuccessMessage);

        return new UpdateStreakResponse(updateStreakSuccessMessage);
    }
}
