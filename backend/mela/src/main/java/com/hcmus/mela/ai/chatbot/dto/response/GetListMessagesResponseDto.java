package com.hcmus.mela.ai.chatbot.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Builder
public class GetListMessagesResponseDto {
    private String object;
    private List<MessageResponseDto> data;
    private String firstId;
    private String lastId;
    private Boolean hasMore;
}
