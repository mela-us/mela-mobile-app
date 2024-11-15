package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Topic;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface TopicRepository extends MongoRepository<Topic, Integer> {
    List<Topic> findByTopicId(Integer topicId);
    List<Topic> findByTopicNameContaining(String topicName);
}
