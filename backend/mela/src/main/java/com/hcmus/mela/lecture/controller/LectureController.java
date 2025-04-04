package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesByLevelResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;
import com.hcmus.mela.lecture.service.LectureService;
import com.hcmus.mela.lecture.service.LectureListService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/lectures")
public class LectureController {

    private final LectureListService lectureListService;

    private final LectureService lectureService;

    private final JwtTokenService jwtTokenService;

    @GetMapping
    @Operation(tags = "Lecture Service", description = "Get lectures with specific level id.")
    public ResponseEntity<GetLecturesByLevelResponse> getLecturesByLevelRequest(
            @Parameter(description = "Level id", example = "[a7e03165-05fc-4e82-b69b-2874aa006caf, cba0ad0e-1f70-412c-a710-a2fef4582ff2, 0f29791a-f7c6-4c6c-9031-850d21f11d32]")
            @RequestParam(value = "levelId") String levelId,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        return ResponseEntity.ok(lectureListService.getLecturesByLevel(userId, UUID.fromString(levelId)));
    }

    @GetMapping("/search")
    @Operation(tags = "Lecture Service", description = "Get lectures by keyword.")
    public ResponseEntity<GetLecturesResponse> getLecturesByKeywordRequest(
            @Parameter(description = "Keyword", example = "a")
            @RequestParam(value = "q") String keyword,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        return ResponseEntity.ok(lectureListService.getLecturesByKeyword(userId, keyword));
    }

    @GetMapping("/recent")
    @Operation(tags = "Lecture Service", description = "Get lecture recently.")
    public ResponseEntity<GetLecturesResponse> getLecturesByRecentRequest(
            @Parameter(description = "Size of lectures", example = "5")
            @RequestParam(value = "size") Integer size,
            @RequestHeader("Authorization") String authorizationHeader) {
        UUID userId = jwtTokenService.getUserIdFromAuthorizationHeader(authorizationHeader);
        return ResponseEntity.ok(lectureListService.getLecturesByRecent(userId, size));
    }

    @GetMapping("/{lectureId}/sections")
    @Operation(tags = "Lecture Section Service", description = "Get lecture sections by lecture id.")
    public ResponseEntity<GetLectureSectionsResponse> getLectureSectionsRequest(
            @Parameter(description = "Lecture id", example = "[54c3abc5-3e8b-4017-acc2-c1005cd51c28, 9c50c1a3-c467-4bcd-a2dd-5db556e69828, 16b21202-b379-4f01-ab08-88d28ecbe94f, 40864bcb-777f-4004-a85a-1482bf66192d]")
            @PathVariable UUID lectureId) {
        return ResponseEntity.ok(lectureService.getLectureSections(lectureId));
    }
}
