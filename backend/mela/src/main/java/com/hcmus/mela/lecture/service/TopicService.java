package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.TopicDto;
import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;
import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.mapper.TopicMapper;
import com.hcmus.mela.lecture.model.Topic;
import com.hcmus.mela.lecture.repository.TopicRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

public interface TopicService {
    public GetTopicsResponse getAllTopics();
}
