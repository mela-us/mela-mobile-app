package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.chatbot.dto.request.CreateConversationRequestDto;
import com.hcmus.mela.ai.chatbot.dto.request.MessageRequestDto;
import com.hcmus.mela.ai.chatbot.dto.response.AiResponseContent;
import com.hcmus.mela.ai.chatbot.dto.response.ConversationMetadataDto;
import com.hcmus.mela.ai.chatbot.dto.response.CreateConversationResponseDto;
import com.hcmus.mela.ai.chatbot.dto.response.MessageResponseDto;
import com.hcmus.mela.ai.chatbot.model.*;
import com.hcmus.mela.ai.chatbot.repository.ConversationRepository;
import com.hcmus.mela.ai.client.config.AiClientProperties;
import com.hcmus.mela.ai.client.web.AiWebClient;
import com.hcmus.mela.ai.client.builder.AiRequestBodyFactory;
import com.hcmus.mela.ai.client.filter.AiResponseFilter;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ConversationServiceImpl implements ConversationService {

    private final AiWebClient aiWebClient;
    private final AiClientProperties.ChatBot chatBotProperties;
    private final ChatBotPrompt chatBotPrompt;
    private final AiRequestBodyFactory aiRequestBodyFactory;
    private final AiResponseFilter aiResponseFilter;
    private final ConversationRepository conversationRepository;

    public ConversationServiceImpl(AiWebClient aiWebClient,
                                   AiClientProperties aiClientProperties,
                                   ChatBotPrompt chatBotPrompt,
                                   AiRequestBodyFactory aiRequestBodyFactory,
                                   ConversationRepository conversationRepository,
                                   AiResponseFilter aiResponseFilter) {
        this.aiWebClient = aiWebClient;
        this.chatBotProperties = aiClientProperties.getChatBot();
        this.chatBotPrompt = chatBotPrompt;
        this.aiRequestBodyFactory = aiRequestBodyFactory;
        this.conversationRepository = conversationRepository;
        this.aiResponseFilter = aiResponseFilter;
    }

    @Override
    public Object identifyProblem(MessageRequestDto messageRequestDto) {

        String textData = messageRequestDto.getText() != null ? messageRequestDto.getText() : "";
        List<String> imageUrls = messageRequestDto.getImageUrl() != null ? List.of(messageRequestDto.getImageUrl()) : List.of();

        Object requestBody = aiRequestBodyFactory.createRequestBodyForChatBot(
                chatBotPrompt.getIdentifyProblem().getInstruction(),
                textData,
                imageUrls,
                chatBotProperties);

        return aiWebClient.fetchAiResponse(chatBotProperties, requestBody);
    }

    @Override
    public Object resolveConfusion(MessageRequestDto messageRequestDto) {
        return null;
    }

    @Override
    public Object reviewSubmission(MessageRequestDto messageRequestDto) {
        return null;
    }

    @Override
    public Object provideSolution(MessageRequestDto messageRequestDto) {
        return null;
    }

    @Override
    public CreateConversationResponseDto sendMessage(MessageRequestDto messageRequestDto, String conversationId) {
        return null;
    }

    @Override
    public CreateConversationResponseDto createConversation(UUID userId, CreateConversationRequestDto createConversationRequestDto) {

        // Create userMessage response
        Date userMessageDate = new Date();
        MessageResponseDto userMessageResponseDto = new MessageResponseDto(
                "user",
                createConversationRequestDto.getMessage().getContent(),
                userMessageDate
        );

        // Call AI service to identify problem
        Object response = identifyProblem(createConversationRequestDto.getMessage());

        // Create userMessage to save to database
        Message savedUserMessage = Message.builder()
                .messageId(UUID.randomUUID())
                .role("user")
                .content(createConversationRequestDto.getMessage().getContent())
                .timestamp(userMessageDate).build();

        // Filter AI response
        String responseText = aiResponseFilter.getMessage(response);
        AiResponseContent aiResponseContent = AiResponseContent.fromJson(responseText);


        Date aiMessageDate = new Date();

        // Create AI message to save to database
        Map<String, Object> aiMessageContent = aiResponseContent.getIdentifyProblemResponse();
        if (aiMessageContent.isEmpty()) {
            aiMessageContent = aiResponseContent.getCommonText();
        }
        Message saveAiMessage = Message.builder()
                .messageId(UUID.randomUUID())
                .role("assistant")
                .content(aiMessageContent)
                .timestamp(aiMessageDate).build();

        // Create summary and metadata
        Summary summary = Summary.builder()
                .latestUpdate(aiMessageDate)
                .context(aiResponseContent.getContextConversation().getOrDefault("context", "").toString())
                .build();

        int totalTokens = aiResponseFilter.getTotalTokens(response);
        Metadata metadata = Metadata
                .builder()
                .totalTokens(totalTokens)
                .status("active")
                .build();

        // Create new conversation
        String title = aiResponseContent.getTitleConversation().getOrDefault("title", "").toString();
        Conversation newConversation = Conversation.builder()
                .conversationId(UUID.randomUUID())
                .userId(userId)
                .title(title)
                .model(chatBotProperties.getModel())
                .messages(List.of(
                        savedUserMessage,
                        saveAiMessage
                ))
                .summary(summary)
                .metadata(metadata)
                .build();

        // Save conversation to database
        conversationRepository.save(newConversation);

        // Add AI message to response
        MessageResponseDto aiMessageResponseDto = new MessageResponseDto(
                "assistant",
                aiMessageContent,
                new Date()
        );

        return new CreateConversationResponseDto(
                UUID.randomUUID(),
                title,
                List.of(userMessageResponseDto, aiMessageResponseDto),
                new ConversationMetadataDto("active", new Date())
        );
    }
}