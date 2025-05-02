package com.hcmus.mela.streak.repository;

import com.hcmus.mela.streak.model.Streak;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface StreakRepository extends MongoRepository<Streak, UUID>, StreakCustomRepository {

    Streak findByUserId(UUID userId);
}
