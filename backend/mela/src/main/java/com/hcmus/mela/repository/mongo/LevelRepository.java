package com.hcmus.mela.repository.mongo;

import com.hcmus.mela.model.mongo.Level;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface LevelRepository extends MongoRepository<Level, String> {
}
