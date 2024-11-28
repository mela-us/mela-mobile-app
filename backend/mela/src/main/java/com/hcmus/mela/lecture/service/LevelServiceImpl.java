package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.LevelDto;
import com.hcmus.mela.lecture.dto.response.GetLevelsResponse;
import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;
import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.mapper.LevelMapper;
import com.hcmus.mela.lecture.mapper.TopicMapper;
import com.hcmus.mela.lecture.model.Level;
import com.hcmus.mela.lecture.model.Topic;
import com.hcmus.mela.lecture.repository.LevelRepository;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LevelServiceImpl implements LevelService{

    private final LevelRepository levelRepository;

    private final GeneralMessageAccessor generalMessageAccessor;

    public GetLevelsResponse getAllLevels() {
        GetLevelsResponse response = new GetLevelsResponse();
        List<Level> levels = levelRepository.findAll();

        response.setMessage(generalMessageAccessor.getMessage(null, "get_levels_success"));
        response.setTotal(levels.size());
        response.setData(levels.stream().map(
                LevelMapper.INSTANCE::levelToLevelDto
        ).collect(Collectors.toList()));

        return response;
    }
}
