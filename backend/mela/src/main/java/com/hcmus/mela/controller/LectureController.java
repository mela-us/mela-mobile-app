package com.hcmus.mela.controller;

import com.hcmus.mela.dto.service.LectureContentDto;
import com.hcmus.mela.dto.service.LectureDto;
import com.hcmus.mela.dto.service.LectureStatsDto;
import com.hcmus.mela.service.LectureService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/lectures")
public class LectureController {

    private final LectureService lectureService;

    @GetMapping
    @Operation(tags = "Lecture Service", description = "Get lectures with specific topic id (null), level id (null) and keyword (null).")
    public ResponseEntity<List<LectureDto>> getLectureRequest(
            @RequestParam(value = "topic", required = false) Integer topicId,
            @RequestParam(value = "level", required = false) Integer levelId,
            @RequestParam(value = "q", required = false) String keyword
    ) {
        return ResponseEntity.ok(lectureService.getLeturesByFilters(topicId, levelId, keyword));
    }

    @GetMapping("/stats")
    @Operation(tags = "Lecture Service", description = "Get lecture stats of the user.")
    public ResponseEntity<List<LectureStatsDto>> getLectureStatsListRequest() {
        return ResponseEntity.ok(lectureService.getLectureStatsLists());
    }

    @GetMapping("/{lectureId}/content")
    @Operation(tags = "Lecture Service", description = "Get lecture content by id.")
    public ResponseEntity<LectureContentDto> getLectureContentRequest(@PathVariable Integer lectureId) {
        return ResponseEntity.ok(lectureService.getLectureContent(lectureId));
    }
}
