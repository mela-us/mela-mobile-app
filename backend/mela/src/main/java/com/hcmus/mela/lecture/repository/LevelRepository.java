package com.hcmus.mela.lecture.repository;

import com.hcmus.mela.lecture.model.Level;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface LevelRepository extends MongoRepository<Level, String> {
}
