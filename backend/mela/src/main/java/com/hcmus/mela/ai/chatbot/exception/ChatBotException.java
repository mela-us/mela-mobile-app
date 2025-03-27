package com.hcmus.mela.ai.chatbot.exception;

public class ChatBotException extends RuntimeException {
    
    public ChatBotException(String message) {
        super(message);
    }
    
    public ChatBotException(String message, Throwable cause) {
        super(message, cause);
    }
}
