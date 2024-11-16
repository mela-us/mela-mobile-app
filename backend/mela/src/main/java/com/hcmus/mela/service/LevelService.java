package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.exceptions.custom.MathContentException;
import com.hcmus.mela.mapper.LevelMapper;
import com.hcmus.mela.model.mongo.Level;
import com.hcmus.mela.repository.mongo.LevelRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LevelService {
    private final LevelRepository levelRepository;

    public List<LevelDto> getAllLevels() {
        List<Level> levelList = levelRepository.findAll();
        if (levelList.isEmpty()) {
            throw new MathContentException("No level is found!");
        }
        return levelList.stream().map(
                LevelMapper.INSTANCE::levelToLevelDto
        ).collect(Collectors.toList());
    }
}
