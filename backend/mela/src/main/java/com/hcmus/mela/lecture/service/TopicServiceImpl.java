package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.TopicDto;
import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;
import com.hcmus.mela.lecture.exception.exception.MathContentException;
import com.hcmus.mela.lecture.mapper.TopicMapper;
import com.hcmus.mela.lecture.model.Topic;
import com.hcmus.mela.lecture.repository.TopicRepository;
import com.hcmus.mela.utils.GeneralMessageAccessor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TopicServiceImpl implements TopicService {
    private final TopicRepository topicRepository;

    private final GeneralMessageAccessor generalMessageAccessor;

    public GetTopicsResponse getAllTopics() {
        GetTopicsResponse response = new GetTopicsResponse();
        List<Topic> topics = topicRepository.findAll();

        response.setMessage(generalMessageAccessor.getMessage(null, "get_topics_success"));
        response.setTotal(topics.size());
        response.setData(topics.stream().map(
                TopicMapper.INSTANCE::topicToTopicDto
        ).collect(Collectors.toList()));

        return response;
    }
}
