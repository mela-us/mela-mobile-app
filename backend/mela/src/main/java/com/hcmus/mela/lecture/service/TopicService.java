package com.hcmus.mela.lecture.service;

import com.hcmus.mela.lecture.dto.response.GetTopicsResponse;
import com.hcmus.mela.lecture.model.Topic;

import java.util.List;

public interface TopicService {

    GetTopicsResponse getTopicsResponse();

    List<Topic> getTopics();
}
