package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.GetConversationHistoryRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.GetListMessagesRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.*;
import com.hcmus.mela.ai.chatbot.model.Conversation;
import com.hcmus.mela.ai.chatbot.model.Message;
import com.hcmus.mela.ai.chatbot.repository.ConversationRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class ConversationHistoryServiceImpl implements ConversationHistoryService{

    private final ConversationRepository conversationRepository;

    @Override
    public GetConversationHistoryResponseDto getConversationHistory(GetConversationHistoryRequestDto request, UUID userId) {
        // Create Pageable object with sorting by createdAt (either asc or desc based on 'order' field)
        Pageable pageable = PageRequest.of(0, request.getLimit(),
                request.getOrder().equals("asc") ? Sort.by(Sort.Order.asc("createdAt")) : Sort.by(Sort.Order.desc("createdAt"))
        );

        List<Conversation> conversations;

        if (request.getAfter() != null) {
            // Fetch conversations after a certain conversationId
            UUID afterId = UUID.fromString(request.getAfter());
            conversations = conversationRepository.findByUserIdAndConversationIdAfter(userId, afterId, pageable);
        } else if (request.getBefore() != null) {
            // Fetch conversations before a certain conversationId
            UUID beforeId = UUID.fromString(request.getBefore());
            conversations = conversationRepository.findByUserIdAndConversationIdBefore(userId, beforeId, pageable);
        } else {
            // Fetch conversations without specific cursor filters
            conversations = conversationRepository.findByUserId(userId, pageable);
        }

        // Prepare the response
        List<ConversationInfoDto> conversationInfoDtos = conversations.stream()
                .map(conversation -> ConversationInfoDto.builder()
                        .conversationId(conversation.getConversationId())
                        .title(conversation.getTitle())
                        .metadata(
                                new ConversationMetadataDto(
                                        conversation.getMetadata().getStatus().name(),
                                        conversation.getMetadata().getCreatedAt())
                        )
                        .build())
                .toList();

        return GetConversationHistoryResponseDto.builder()
                .object("list")
                .data(conversationInfoDtos)
                .firstId(conversationInfoDtos.isEmpty() ? null : conversationInfoDtos.get(0).getConversationId().toString())
                .lastId(conversationInfoDtos.isEmpty() ? null : conversationInfoDtos.get(conversationInfoDtos.size() - 1).getConversationId().toString())
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
                                conversation.getMetadata().getCreatedAt())
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
            throw new RuntimeException("Conversation not found");
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
