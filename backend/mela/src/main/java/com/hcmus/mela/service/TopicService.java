package com.hcmus.mela.service;

import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.dto.service.TopicDto;
import com.hcmus.mela.exceptions.custom.MathContentException;
import com.hcmus.mela.mapper.LevelMapper;
import com.hcmus.mela.mapper.TopicMapper;
import com.hcmus.mela.model.mongo.Level;
import com.hcmus.mela.model.mongo.Topic;
import com.hcmus.mela.repository.mongo.LevelRepository;
import com.hcmus.mela.repository.mongo.TopicRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TopicService {
    private final TopicRepository topicRepository;

    public List<TopicDto> getAllTopics() {
        List<Topic> topicList = topicRepository.findAll();
        if (topicList.isEmpty()) {
            throw new MathContentException("No topic is found!");
        }
        return topicList.stream().map(
                TopicMapper.INSTANCE::topicToTopicDto
        ).collect(Collectors.toList());
    }
}
