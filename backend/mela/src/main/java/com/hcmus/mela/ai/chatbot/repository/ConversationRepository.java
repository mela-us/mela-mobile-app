package com.hcmus.mela.ai.chatbot.repository;

import com.hcmus.mela.ai.chatbot.model.Conversation;
import com.hcmus.mela.ai.chatbot.model.Message;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public interface ConversationRepository extends MongoRepository<Conversation, UUID> {
    Optional<Conversation> findByConversationIdAndUserId(UUID id, UUID userId);

    // Define a method to get all key messages from a specific conversation by its ID
    default List<Message> getKeyMessages(UUID conversationId) {
        Optional<Conversation> conversation = findById(conversationId);

        if (conversation.isPresent() && conversation.get().getMessages() != null && conversation.get().getSummary() != null && conversation.get().getSummary().getKeyMessages() != null) {
            List<UUID> keyMessageIds = conversation.get().getSummary().getKeyMessages();
            return conversation.get().getMessages().stream()
                    .filter(message -> keyMessageIds.contains(message.getMessageId()))
                    .collect(Collectors.toList());
        } else {
            return null; // Or return an empty list: return Collections.emptyList();
        }
    }
}
