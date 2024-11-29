package com.hcmus.mela.lecture.controller;

import com.hcmus.mela.lecture.dto.response.GetLectureSectionsResponse;
import com.hcmus.mela.lecture.dto.response.GetLecturesResponse;
import com.hcmus.mela.lecture.service.LectureServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.bson.UuidRepresentation;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/lectures")
public class LectureController {

    private final LectureServiceImpl lectureService;

    @GetMapping
    @Operation(tags = "Lecture Service", description = "Get lectures with specific topic id")
    public ResponseEntity<GetLecturesResponse> getLecturesByTopicRequest(
            @RequestParam(value = "topicId") String topicId,
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        return ResponseEntity.ok(lectureService.getLecturesByTopic(authorizationHeader, UUID.fromString(topicId)));
    }

    @GetMapping("/search")
    @Operation(tags = "Lecture Service", description = "Get lectures with keyword.")
    public ResponseEntity<GetLecturesResponse> getLecturesByKeywordRequest(
            @RequestParam(value = "q") String keyword,
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        return ResponseEntity.ok(lectureService.getLecturesByKeyword(authorizationHeader, keyword));
    }

    @GetMapping("/recent")
    @Operation(tags = "Lecture Service", description = "Get lecture recently.")
    public ResponseEntity<GetLecturesResponse> getLecturesByRecentRequest(
            @RequestParam(value = "size") Integer size,
            @RequestHeader("Authorization") String authorizationHeader
    ) {
        return ResponseEntity.ok(lectureService.getLecturesByRecent(authorizationHeader, size));
    }

    @GetMapping("/{lectureId}/sections")
    @Operation(tags = "Lecture Service", description = "Get lecture sections by lecture id.")
    public ResponseEntity<GetLectureSectionsResponse> getLectureSectionsRequest(@PathVariable UUID lectureId) {
        return ResponseEntity.ok(lectureService.getLectureSections(lectureId));
    }
}
