package com.hcmus.mela.ai.chatbot.repository;

import com.hcmus.mela.ai.chatbot.model.Conversation;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface ConversationRepository extends MongoRepository<Conversation, UUID> {

}
