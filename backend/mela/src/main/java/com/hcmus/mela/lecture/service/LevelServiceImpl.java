package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.LevelDto;
import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.mapper.LevelMapper;
import com.hcmus.mela.lecture.model.Level;
import com.hcmus.mela.lecture.repository.LevelRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LevelServiceImpl {
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
