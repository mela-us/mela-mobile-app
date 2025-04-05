package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesByLevelResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;
import com.hcmus.mela.lecture.exception.LectureException;
import com.hcmus.mela.lecture.service.LectureListService;
import com.hcmus.mela.lecture.service.LectureService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/lectures")
@Slf4j
public class LectureController {

    private final LectureListService lectureListService;
    private final LectureService lectureService;
    private final JwtTokenService jwtTokenService;

    @GetMapping
    @Operation(
            tags = "Lecture Service",
            summary = "Get lectures by level ID",
            description = "Retrieves all lectures associated with the specified level ID."
    )
    public ResponseEntity<GetLecturesByLevelResponse> getLecturesByLevelRequest(
            @Parameter(description = "Level ID (UUID format)", example = "a7e03165-05fc-4e82-b69b-2874aa006caf")
            @RequestParam(value = "levelId") String levelId,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        UUID levelUuid = UUID.fromString(levelId);

        log.info("Getting lectures for level: {} and user: {}", levelId, userId);
        GetLecturesByLevelResponse response = lectureListService.getLecturesByLevel(userId, levelUuid);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    @Operation(
            tags = "Lecture Service",
            summary = "Search lectures by keyword",
            description = "Searches for lectures that match the given keyword in title or content."
    )
    public ResponseEntity<GetLecturesResponse> getLecturesByKeywordRequest(
            @Parameter(description = "Search keyword", example = "math")
            @RequestParam(value = "q") String keyword,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Searching lectures with keyword: '{}' for user: {}", keyword, userId);
        GetLecturesResponse response = lectureListService.getLecturesByKeyword(userId, keyword);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/recent")
    @Operation(
            tags = "Lecture Service",
            summary = "Get recent lectures",
            description = "Retrieves the most recent lectures up to the specified size limit."
    )
    public ResponseEntity<GetLecturesResponse> getLecturesByRecentRequest(
            @Parameter(description = "Number of recent lectures to retrieve", example = "5")
            @RequestParam(value = "size") Integer size,
            @RequestHeader("Authorization") String authorizationHeader) {
        if (size <= 0) {
            throw new LectureException("Size parameter must be a positive integer");
        }
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);

        log.info("Getting {} recent lectures for user: {}", size, userId);
        GetLecturesResponse response = lectureListService.getLecturesByRecent(userId, size);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{lectureId}/sections")
    @Operation(
            tags = "Lecture Section Service",
            summary = "Get lecture sections",
            description = "Retrieves all sections associated with the specified lecture ID."
    )
    public ResponseEntity<GetLectureSectionsResponse> getLectureSectionsRequest(
            @Parameter(description = "Lecture ID (UUID format)", example = "54c3abc5-3e8b-4017-acc2-c1005cd51c28")
            @PathVariable String lectureId) {
        UUID lectureUuid = UUID.fromString(lectureId);

        log.info("Getting sections for lecture: {}", lectureId);
        GetLectureSectionsResponse response = lectureService.getLectureSections(lectureUuid);

        return ResponseEntity.ok(response);
    }
}
