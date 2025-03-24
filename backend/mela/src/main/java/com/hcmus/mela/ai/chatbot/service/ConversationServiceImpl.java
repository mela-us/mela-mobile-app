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
                    "content": "Bài toán:\\n<[<img src='https://mela-storage-dev.s3.ap-southeast-1.amazonaws.com/exercises/images/lop5/K5_06.png'>]>\\n\\nBài giải:\\n<[<img src='https://mela-storage-dev.s3.ap-southeast-1.amazonaws.com/exercises/images/lop5/K5_07.png'>]>\\n\\nChọn ra 01 phương pháp giải tiêu biểu từ bài toán và bài giải, liệt kê các bước giải chính và giải thích vắn tắt từng bước giải của phương pháp giải đó; sao cho phù hợp với học sinh lớp <5> để học sinh bắt đầu giải bài toán , dựa theo bối cảnh dưới đây.\\n\\nBối cảnh: Bạn là giáo viên dạy toán lớp <class> chương trình toán phổ thông Việt Nam. Em học sinh lớp <class> cần bạn gợi ý cho bài toán mà em ấy không hiểu theo cách phù hợp, dễ hiểu nhất với học sinh lớp <5> để giúp em tìm ra cách giải bài toán\\n\\nƯu tiên phương pháp giải nằm trong chương trình học lớp <class>, phương pháp giải ngắn gọn, có áp dụng các công thức đã học trong chương trình. Câu trả lời chỉ được chứa phương pháp giải ở hàng trên cùng, tên phương pháp đặt sau cụm “Phương pháp giải:”. Mỗi hàng tiếp theo chứa từng bước giải của phương pháp đó. Tên phương pháp, tên bước giải (hoặc tên đánh số), được in đậm. Nếu bước giải không có tên thì đánh số từ 1 tới hết, nếu có tên thì không được đánh số. Giải thích vắn tắt từng bước giải đặt sau dấu hai chấm, in thường. Không được giải bài toán, không được ra đáp số. Không được thực hiện các bước tính toán."
                }
            ]
        }
        """.formatted(aiModel);

            String response = webClient.post()
                    .uri(chatBotProperties.getPath())
                    .bodyValue("{\"model\":\"" + chatBotProperties.getModel() + "\", \"messages\":[{\"role\":\"user\", \"content\":\"Hello\"}]}")
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
