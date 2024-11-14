package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.ExampleMongoDBEntity;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ExampleRepository extends MongoRepository<ExampleMongoDBEntity, Integer> {
}
