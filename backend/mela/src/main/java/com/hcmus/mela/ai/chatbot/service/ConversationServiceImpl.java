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
    private final AiClientProperties.ChatBot chatBotProperties;

    public ConversationServiceImpl(AiWebClient aiWebClient, AiClientProperties aiClientProperties) {
        this.webClient = aiWebClient.getWebClientForChatBot();
        this.chatBotProperties = aiClientProperties.getChatBot();
    }

    @Override
    public String testChat() {
        try {
            String requestBody = """
    {
        "model": "%s",
        "messages": [
            {
                "role": "user",
                "content": "data: Học sinh gửi bài tập dưới dạng văn bản hoặc hình ảnh. Xử lý đầu vào như sau: text: Giải thích định lý viet.
                    conditions: {
                        invalid_input: Nếu học sinh gửi sai định dạng (không phải văn bản hoặc hình ảnh rõ ràng), phản hồi: 'Bạn hãy gửi bài tập dưới dạng văn bản hoặc hình ảnh rõ ràng nhé!' ,
                        valid_input: Nếu học sinh gửi đúng định dạng, tiến hành phân tích bài toán theo các phần sau:
                    },
                    structure: {
                        analysis: Nhận dạng đề bài và xác định dạng bài toán.,
                        solution_method: Đưa ra phương pháp giải chung và liệt kê các công thức áp dụng.,
                        steps: Danh sách các bước làm, mỗi bước có tiêu đề ngắn gọn và mô tả hướng dẫn (không cung cấp kết quả, chỉ hướng dẫn dễ hiểu, mang tính khơi gợi, thúc đẩy học sinh tự suy nghĩ).,
                        advice: Lời động viên ngắn, khuyến khích học sinh tự làm và đề nghị gửi bài để nhận nhận xét.,
                        relative_terms: Liệt kê tối đa 5 khái niệm hoặc thuật ngữ liên quan đến dạng bài toán.
                    },
                    instruction: Bối cảnh: Bạn là giáo viên hoặc gia sư dạy toán thuộc chương trình tiểu học và trung học cơ sở tại Việt Nam. Học sinh cần bạn hướng dẫn một cách dễ hiểu, phù hợp với trình độ của mình.,
                    requirement: Trình bày công thức theo chuẩn LaTeX, sử dụng tiếng Việt, luôn có kết luận cuối bài. Xưng hô với học sinh là 'bạn', còn người trả lời là 'mình'."
            }
        ]
    }
        """.formatted(chatBotProperties.getModel());

            String response = webClient.post()
                    .uri(chatBotProperties.getPath())
                    .bodyValue(requestBody)
                    .retrieve()
                    .onStatus(
                            status -> status.is4xxClientError() || status.is5xxServerError(),
                            clientResponse -> clientResponse.bodyToMono(String.class)
                                    .flatMap(errorBody -> {
                                        logger.error("API Error: {}", errorBody);
                                        return clientResponse.createException();
                                    })
                    )
                    .bodyToMono(String.class)
                    .block();


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
