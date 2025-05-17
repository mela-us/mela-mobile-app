package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.dto.TopicDto;
import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;

import java.util.List;

public interface TopicService {

    GetTopicsResponse getTopicsResponse();

    List<TopicDto> getTopics();
}
