package com.hcmus.mela.ai.chatbot.repository;

import com.hcmus.mela.ai.chatbot.model.Conversation;
import com.hcmus.mela.ai.chatbot.model.Message;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Repository
public interface ConversationRepository extends MongoRepository<Conversation, UUID> {

    List<Conversation> findAllByUserId(UUID userId);

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

    /**
     * Get the list of messages after a given messageId with pagination.
     */
    default List<Message> getMessagesAfter(UUID conversationId, UUID afterId, int limit) {
        Optional<Conversation> conversation = findById(conversationId);

        if (conversation.isPresent() && conversation.get().getMessages() != null) {
            return conversation.get().getMessages().stream()
                    .filter(message -> message.getMessageId().compareTo(afterId) > 0) // 'after' means greater than
                    .limit(limit)
                    .collect(Collectors.toList());
        } else {
            return null; // Or return an empty list: return Collections.emptyList();
        }
    }

    /**
     * Get the list of messages before a given messageId with pagination.
     */
    default List<Message> getMessagesBefore(UUID conversationId, UUID beforeId, int limit) {
        Optional<Conversation> conversation = findById(conversationId);

        if (conversation.isPresent() && conversation.get().getMessages() != null) {
            return conversation.get().getMessages().stream()
                    .filter(message -> message.getMessageId().compareTo(beforeId) < 0) // 'before' means less than
                    .limit(limit)
                    .collect(Collectors.toList());
        } else {
            return null; // Or return an empty list: return Collections.emptyList();
        }
    }

    /**
     * Get the list of messages in a conversation with pagination.
     */
    default List<Message> getMessages(UUID conversationId, int limit) {
        Optional<Conversation> conversation = findById(conversationId);

        if (conversation.isPresent() && conversation.get().getMessages() != null) {
            List<Message> messages = conversation.get().getMessages();
            int fromIndex = Math.max(messages.size() - limit, 0);
            return messages.subList(fromIndex, messages.size());
        } else {
            return null;
        }
    }

    // Custom method to delete a conversation by conversationId
    void deleteByConversationId(UUID conversationId);

    // Method to check if a conversation exists
    boolean existsByConversationId(UUID conversationId);
}
