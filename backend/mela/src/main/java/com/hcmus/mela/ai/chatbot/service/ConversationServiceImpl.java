package com.hcmus.mela.ai.chatbot.service;

import com.hcmus.mela.ai.client.AiClientProperties;
import com.hcmus.mela.ai.client.AiWebClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;

@Service
public class ConversationServiceImpl implements ConversationService {
    private static final Logger logger = LoggerFactory.getLogger(ConversationServiceImpl.class);
    private final WebClient webClient;
    private final String aiModel;

    public ConversationServiceImpl(AiWebClient aiWebClient, AiClientProperties aiClientProperties) {
        this.webClient = aiWebClient.getWebClientForChatBot();
        this.aiModel = aiClientProperties.getChatBot().getModel();
    }

    @Override
    public String testChat() {
        try {
            String response = webClient.post()
                    .uri("/chat/completions")
                    .bodyValue("{\"model\":\"" + aiModel + "\", \"messages\":[{\"role\":\"user\", \"content\":\"Hello\"}]}")
                    .retrieve()
                    .onStatus(
                            status -> status.is4xxClientError() || status.is5xxServerError(),
                            clientResponse -> clientResponse.bodyToMono(String.class)
                                    .flatMap(errorBody -> {
                                        logger.error("API Error: {}", errorBody);
                                        return clientResponse.createException();
                                    })
                    )
                    .bodyToMono(String.class) // Chuyển phản hồi từ API thành String
                    .block(); // Đợi phản hồi từ API (blocking)

            logger.info("API Response: {}", response);
            return response;
        } catch (WebClientResponseException e) {
            return "Error: " + e.getResponseBodyAsString();
        } catch (Exception e) {
            logger.error("Unexpected error: ", e);
            return "Unexpected error: " + e.getMessage();
        }
    }
}
