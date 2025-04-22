package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.GetConversationHistoryRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.GetListMessagesRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.*;
import com.hcmus.mela.ai.chatbot.model.Conversation;
import com.hcmus.mela.ai.chatbot.model.Message;
import com.hcmus.mela.ai.chatbot.repository.ConversationRepository;
import com.hcmus.mela.ai.client.exception.ApiException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class ConversationHistoryServiceImpl implements ConversationHistoryService{

    private final ConversationRepository conversationRepository;

    @Override
    public GetConversationHistoryResponseDto getConversationHistory(GetConversationHistoryRequestDto request, UUID userId) {

        List<Conversation> conversations = conversationRepository.findAllByUserId(userId);

        if ("asc".equals(request.getOrder())) {
            conversations.sort((c1, c2) -> c1.getMetadata().getUpdatedAt().compareTo(c2.getMetadata().getUpdatedAt()));
        } else if ("desc".equals(request.getOrder())) {
            conversations.sort((c1, c2) -> c2.getMetadata().getUpdatedAt().compareTo(c1.getMetadata().getUpdatedAt()));
        }

        // Apply pagination
        if(request.getUpdatedAtAfter() != null) {
            conversations = conversations.stream()
                    .filter(conversation -> conversation.getMetadata().getUpdatedAt().after(request.getUpdatedAtAfter()))
                    .toList();
        }
        if(request.getUpdatedAtBefore() != null) {
            conversations = conversations.stream()
                    .filter(conversation -> conversation.getMetadata().getUpdatedAt().before(request.getUpdatedAtBefore()))
                    .toList();
        }

        conversations = conversations.stream()
                .limit(request.getLimit())
                .toList();

        // Prepare the response
        List<ConversationInfoDto> conversationInfoDtos = conversations.stream()
                .map(conversation -> ConversationInfoDto.builder()
                        .conversationId(conversation.getConversationId())
                        .title(conversation.getTitle())
                        .metadata(
                                new ConversationMetadataDto(
                                        conversation.getMetadata().getStatus().name(),
                                        conversation.getMetadata().getCreatedAt(),
                                        conversation.getMetadata().getUpdatedAt())
                        )
                        .build())
                .toList();

        return GetConversationHistoryResponseDto.builder()
                .object("list")
                .data(conversationInfoDtos)
                .firstUpdatedAt(conversations.isEmpty() ? null : conversations.get(0).getMetadata().getUpdatedAt())
                .lastUpdatedAt(conversations.isEmpty() ? null : conversations.get(conversations.size() - 1).getMetadata().getUpdatedAt())
                .hasMore(conversationInfoDtos.size() == request.getLimit())
                .build();
    }

    @Override
    public ConversationInfoDto getConversation(UUID conversationId) {
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new RuntimeException("Conversation not found"));

        return ConversationInfoDto.builder()
                .conversationId(conversation.getConversationId())
                .title(conversation.getTitle())
                .metadata(
                        new ConversationMetadataDto(
                                conversation.getMetadata().getStatus().name(),
                                conversation.getMetadata().getCreatedAt(),
                                conversation.getMetadata().getUpdatedAt())
                )
                .build();
    }

    @Override
    public void deleteConversation(UUID conversationId) {
        // Check if the conversation exists
        if (!conversationRepository.existsByConversationId(conversationId)) {
            throw new RuntimeException("Conversation not found");
        }
        conversationRepository.deleteByConversationId(conversationId);
    }

    @Override
    public GetListMessagesResponseDto getListMessages(GetListMessagesRequestDto request, UUID conversationId) {
        if(!conversationRepository.existsByConversationId(conversationId)) {
            throw new ApiException(404, "Conversation not found");
        }
        List<Message> messages;

        if (request.getAfter() != null) {
            // Fetch messages after a certain messageId
            UUID afterId = UUID.fromString(request.getAfter());
            messages = conversationRepository.getMessagesAfter(conversationId, afterId, request.getLimit());
        } else if (request.getBefore() != null) {
            // Fetch messages before a certain messageId
            UUID beforeId = UUID.fromString(request.getBefore());
            messages = conversationRepository.getMessagesBefore(conversationId, beforeId, request.getLimit());
        } else {
            // Fetch messages without specific cursor filters
            messages = conversationRepository.getMessages(conversationId, request.getLimit());
        }

        // Prepare the response
        List<MessageResponseDto> messageResponseDtos = messages.stream()
                .map(message -> MessageResponseDto.builder()
                        .messageId(message.getMessageId())
                        .role(message.getRole())
                        .content(message.getContent())
                        .timestamp(message.getTimestamp())
                        .build())
                .toList();

        return GetListMessagesResponseDto.builder()
                .object("list")
                .data(messageResponseDtos)
                .firstId(messages.isEmpty() ? null : messages.get(0).getMessageId().toString())
                .lastId(messages.isEmpty() ? null : messages.get(messages.size() - 1).getMessageId().toString())
                .hasMore(messages.size() == request.getLimit())
                .build();
    }
}
