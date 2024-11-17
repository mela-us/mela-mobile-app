package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Topic;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface TopicRepository extends MongoRepository<Topic, String> {
}
