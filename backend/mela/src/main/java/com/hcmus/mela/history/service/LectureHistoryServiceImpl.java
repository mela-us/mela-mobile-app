package com.hcmus.mela.history.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.history.dto.dto.LectureHistoryDto;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.dto.request.SaveLectureSectionRequest;
import com.hcmus.mela.history.dto.response.SaveLectureSectionResponse;
import com.hcmus.mela.history.exception.HistoryException;
import com.hcmus.mela.history.mapper.LectureHistoryMapper;
import com.hcmus.mela.history.model.LectureCompletedSection;
import com.hcmus.mela.history.model.LectureHistory;
import com.hcmus.mela.history.repository.LectureHistoryRepository;
import com.hcmus.mela.lecture.dto.dto.LectureDto;
import com.hcmus.mela.lecture.service.LectureService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@AllArgsConstructor
@Service
public class LectureHistoryServiceImpl implements LectureHistoryService {

    private final LectureHistoryRepository lectureHistoryRepository;

    private final LectureService lectureService;

    private final JwtTokenService jwtTokenService;

    @Override
    public SaveLectureSectionResponse saveSection(String authorizationHeader, SaveLectureSectionRequest saveLectureSectionRequest) {
        UUID userId = jwtTokenService.getUserIdFromToken(
                jwtTokenService.extractTokenFromAuthorizationHeader(authorizationHeader));

        LectureHistory lectureHistory = lectureHistoryRepository.findByLectureIdAndUserId(saveLectureSectionRequest.getLectureId(), userId);
        LectureDto lectureInfo = lectureService.getLectureById(saveLectureSectionRequest.getLectureId());

        if (lectureInfo == null) {
            throw new HistoryException("Lecture not found!");
        }

        boolean isUpdated = (lectureHistory != null && lectureHistory.getCompletedSections() != null);
        boolean isCompleted = false;
        if (!isUpdated) {
            lectureHistory = new LectureHistory();
            lectureHistory.setStartedAt(saveLectureSectionRequest.getCompletedAt());
        } else {
            isCompleted = lectureHistory.getProgress().equals(100);
        }
        List<LectureCompletedSection> completedSections = lectureHistory.getCompletedSections();
        if (completedSections == null) {
            completedSections = new ArrayList<>();
        }

        LectureCompletedSection lectureCompletedSection = completedSections
                .stream()
                .filter(section -> section.getOrdinalNumber().equals(saveLectureSectionRequest.getOrdinalNumber()))
                .findFirst().orElse(null);
        if (lectureCompletedSection == null) {
            lectureCompletedSection = new LectureCompletedSection();
            lectureCompletedSection.setOrdinalNumber(saveLectureSectionRequest.getOrdinalNumber());
            completedSections.add(lectureCompletedSection);
        }
        lectureCompletedSection.setCompletedAt(saveLectureSectionRequest.getCompletedAt());
        completedSections.sort(Comparator.comparing(LectureCompletedSection::getCompletedAt).reversed());

        int completedSectionsCount = completedSections.size();
        int sectionsCount = lectureInfo.getSections().size();
        Integer progress = (int)(completedSectionsCount * 1.0 / sectionsCount * 100);
        if (progress.equals(100) && !isCompleted) {
            lectureHistory.setCompletedAt(saveLectureSectionRequest.getCompletedAt());
        }

        lectureHistory.setId(isUpdated ? lectureHistory.getId() : UUID.randomUUID());
        lectureHistory.setUserId(userId);
        lectureHistory.setLectureId(saveLectureSectionRequest.getLectureId());
        lectureHistory.setTopicId(lectureInfo.getTopicId());
        lectureHistory.setLevelId(lectureInfo.getLevelId());
        lectureHistory.setProgress(progress);
        lectureHistory.setCompletedSections(completedSections);

        if (isUpdated) {
            lectureHistoryRepository.updateFirstById(lectureHistory.getId(), lectureHistory);
        } else {
            lectureHistoryRepository.save(lectureHistory);
        }

        return new SaveLectureSectionResponse("Save lecture section successfully!");
    }

    @Override
    public List<RecentActivityDto> getRecentActivity(UUID userId) {
        List<LectureHistory> lectureHistories = lectureHistoryRepository.findAllByUserId(userId);
        if (lectureHistories.isEmpty()) {
            return List.of();
        }
        return lectureHistories
                .stream()
                .map(lectureHistory -> {
                    List<LectureCompletedSection> completedSections = lectureHistory.getCompletedSections();
                    LectureCompletedSection mostRecentSection = completedSections
                            .stream()
                            .max(Comparator.comparing(LectureCompletedSection::getCompletedAt))
                            .orElse(null);
                    RecentActivityDto recentActivityDto = new RecentActivityDto(
                            lectureHistory.getLectureId(), LocalDateTime.of(2000,1,1, 1,1,1));
                    if (mostRecentSection != null) {
                        recentActivityDto.setDate(mostRecentSection.getCompletedAt());
                    }
                    return recentActivityDto;})
                .toList();
    }

    @Override
    public List<LectureHistoryDto> getLectureHistoryByUserAndLevel(UUID userId, UUID levelId) {
        List<LectureHistory> lectureHistories = lectureHistoryRepository.findAllByUserIdAndLevelId(userId, levelId);
        if (lectureHistories.isEmpty()) {
            return new ArrayList<>();
        }
        return lectureHistories.stream().map(LectureHistoryMapper.INSTANCE::converToLectureHistoryDto).toList();
    }
}