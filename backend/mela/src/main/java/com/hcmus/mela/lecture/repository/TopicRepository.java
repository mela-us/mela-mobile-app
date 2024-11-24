package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Topic;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface TopicRepository extends MongoRepository<Topic, String> {
}
