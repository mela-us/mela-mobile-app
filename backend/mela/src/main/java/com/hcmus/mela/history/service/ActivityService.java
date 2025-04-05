package com.hcmus.mela.history.service;

import com.hcmus.mela.history.dto.dto.RecentActivityDto;

import java.util.List;
import java.util.UUID;

public interface ActivityService {

    List<RecentActivityDto> getRecentActivityOfUser(UUID userId, Integer size);
}