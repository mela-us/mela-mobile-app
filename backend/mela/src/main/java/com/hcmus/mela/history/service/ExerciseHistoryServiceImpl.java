package com.hcmus.mela.history.service;

import com.hcmus.mela.auth.security.jwt.JwtTokenService;
import com.hcmus.mela.exercise.dto.dto.ExerciseDto;
import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.model.ExerciseStatus;
import com.hcmus.mela.exercise.service.ExerciseInfoService;
import com.hcmus.mela.exercise.service.ExerciseResultService;
import com.hcmus.mela.history.dto.dto.CheckedAnswerDto;
import com.hcmus.mela.history.dto.dto.ExerciseHistoryDto;
import com.hcmus.mela.history.dto.dto.RecentActivityDto;
import com.hcmus.mela.history.dto.request.ExerciseResultRequest;
import com.hcmus.mela.history.dto.response.ExerciseResultResponse;
import com.hcmus.mela.history.mapper.ExerciseHistoryMapper;
import com.hcmus.mela.history.mapper.RecentActivityMapper;
import com.hcmus.mela.history.model.ExerciseAnswer;
import com.hcmus.mela.history.model.ExerciseHistory;
import com.hcmus.mela.history.model.ExercisesCountByLecture;
import com.hcmus.mela.history.repository.ExerciseHistoryRepository;
import com.hcmus.mela.lecture.dto.dto.LectureDto;
import com.hcmus.mela.lecture.service.LectureService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@AllArgsConstructor
public class ExerciseHistoryServiceImpl implements ExerciseHistoryService {

    private final ExerciseHistoryRepository exerciseHistoryRepository;

    private final LectureService lectureService;

    private final ExerciseInfoService exerciseInfoService;

    private final ExerciseResultService exerciseResultService;

    private final JwtTokenService jwtTokenService;

    @Override
    public ExerciseResultResponse getExerciseResultResponse(UUID userId, ExerciseResultRequest exerciseResultRequest) {
        saveExercise(exerciseResultRequest, userId);

        List<CheckedAnswerDto> checkedAnswerDtoList = exerciseResultRequest.getAnswers().stream()
                .map(answer -> CheckedAnswerDto.builder()
                        .questionId(answer.getQuestionId())
                        .isCorrect(answer.getIsCorrect())
                        .build())
                .toList();
        return ExerciseResultResponse.builder()
                .message("Exercise result saved successfully")
                .build();
    }

    private void saveExercise(ExerciseResultRequest exerciseResultRequest, UUID userId) {
        ExerciseDto exerciseInfo = exerciseInfoService.findByExerciseId(exerciseResultRequest.getExerciseId());
        LectureDto lectureInfo = lectureService.getLectureById(exerciseInfo.getLectureId());

        List<ExerciseAnswer> answers = exerciseResultRequest.getAnswers().stream()
                .map(answer -> ExerciseAnswer.builder()
                        .questionId(answer.getQuestionId())
                        .isCorrect(answer.getIsCorrect())
                        .blankAnswer(answer.getBlankAnswer())
                        .selectedOption(answer.getSelectedOption())
                        .build())
                .toList();

        Double score = answers.stream()
                .filter(ExerciseAnswer::getIsCorrect)
                .count() * 1.0 / answers.size() * 100;

        ExerciseHistory exerciseHistory = ExerciseHistory.builder()
                .id(UUID.randomUUID())
                .lectureId(lectureInfo.getLectureId())
                .userId(userId)
                .exerciseId(exerciseInfo.getExerciseId())
                .levelId(lectureInfo.getLevelId())
                .topicId(lectureInfo.getTopicId())
                .score(score)
                .startedAt(exerciseResultRequest.getStartedAt())
                .completedAt(exerciseResultRequest.getCompletedAt())
                .answers(answers)
                .build();

        exerciseHistoryRepository.save(exerciseHistory);
    }

    @Override
    public Map<UUID, Integer> getPassedExerciseCountOfUser(UUID userId) {
        List<ExercisesCountByLecture> exercisesCountByLectureList = exerciseHistoryRepository.countTotalPassExerciseOfUser(userId, 80.0);
        if (exercisesCountByLectureList.isEmpty()) {
            return new HashMap<>();
        }
        return exercisesCountByLectureList.stream().collect(
                HashMap::new,
                (map, exercisesCountByLecture) -> map.put(exercisesCountByLecture.getLectureId(), exercisesCountByLecture.getTotalExercises()),
                HashMap::putAll);
    }

    @Override
    public Map<UUID, ExerciseResultDto> getExerciseBestResultOfUser(List<UUID> exerciseIdList, UUID userId) {
        if (exerciseIdList.isEmpty()) return new HashMap<>();
        List<ExerciseHistory> exerciseHistories = exerciseHistoryRepository.findAllByUserIdAndExerciseIdList(userId, exerciseIdList);
        Map<UUID, ExerciseResultDto> exerciseResultDtoMap = new HashMap<>();

        for (UUID exerciseId : exerciseIdList) {
            ExerciseResultDto exerciseResultDto = new ExerciseResultDto();
            exerciseResultDto.setStatus(ExerciseStatus.NOT_START);
            exerciseResultDtoMap.put(exerciseId, exerciseResultDto);
        }

        for(ExerciseHistory exerciseHistory: exerciseHistories) {
            Double score = exerciseHistory.getScore();
            ExerciseStatus status = score >= 80 ? ExerciseStatus.PASS : ExerciseStatus.IN_PROGRESS;
            Integer totalAnswers = exerciseHistory.getAnswers().size();
            Integer totalCorrectAnswers =  (int)Math.round(totalAnswers * score / 100);

            Integer innerTotalCorrectAnswers = -1;
            ExerciseResultDto exerciseResultDto = exerciseResultDtoMap.getOrDefault(exerciseHistory.getExerciseId(), null);
            if (exerciseResultDto != null) {
                innerTotalCorrectAnswers = exerciseResultDto.getTotalCorrectAnswers();
            }
            if (innerTotalCorrectAnswers.compareTo(totalCorrectAnswers) < 0) {
                exerciseResultDtoMap.put(
                        exerciseHistory.getExerciseId(),
                        ExerciseResultDto.builder()
                                .totalAnswers(totalAnswers)
                                .totalCorrectAnswers(totalCorrectAnswers)
                                .status(status)
                                .build());
            }
        }

        return exerciseResultDtoMap;
    }

    @Override
    public List<ExerciseHistoryDto> getExerciseHistoryByUserAndLevel(UUID userId, UUID levelId) {
        List<ExerciseHistory> exerciseHistories = exerciseHistoryRepository.findAllByUserIdAndLevelId(userId, levelId);
        if (exerciseHistories.isEmpty()) {
            return new ArrayList<>();
        }
        return exerciseHistories.stream().map(ExerciseHistoryMapper.INSTANCE::converToExerciseHistoryDto).toList();
    }
}
