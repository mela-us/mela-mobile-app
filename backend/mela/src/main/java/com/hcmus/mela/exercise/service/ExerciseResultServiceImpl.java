package com.hcmus.mela.exercise.service;

import com.hcmus.mela.exercise.dto.dto.ExerciseResultDto;
import com.hcmus.mela.exercise.mapper.ExerciseMapper;
import com.hcmus.mela.exercise.mapper.ExerciseResultMapper;
import com.hcmus.mela.exercise.model.ExerciseResult;
import com.hcmus.mela.exercise.repository.ExerciseResultRepository;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.*;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExerciseResultServiceImpl implements ExerciseResultService {
    private static final String RESULTS_FOUND = "results_found_successful";
    private final GeneralMessageAccessor generalMessageAccessor;
    private final ExerciseResultRepository exerciseResultRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    public List<ExerciseResult> findAllByUserIdAndExerciseId(UUID userId, UUID exerciseId) {
        return exerciseResultRepository.findAllByUserIdAndExerciseId(userId, exerciseId);
    }

    @Override
    public ExerciseResultDto getBestExerciseResult(UUID userId, UUID exerciseId) {
        SortOperation sortStage = Aggregation.sort(Sort.Direction.DESC, "total_correct_answers");

        LimitOperation limitStage = Aggregation.limit(1);

        Aggregation aggregation = Aggregation.newAggregation(
                sortStage,
                limitStage
        );

        List<ExerciseResult> results = mongoTemplate.aggregate(
                aggregation,
                "exercise_results",
                ExerciseResult.class
        ).getMappedResults();

        if (results.isEmpty()) {
            return null;
        }

        final String resultSuccessMessage = generalMessageAccessor.getMessage(null, RESULTS_FOUND, exerciseId, userId);
        log.info(resultSuccessMessage);
        return ExerciseResultMapper.INSTANCE.convertToExerciseResultDto(results.get(0));
    }
}