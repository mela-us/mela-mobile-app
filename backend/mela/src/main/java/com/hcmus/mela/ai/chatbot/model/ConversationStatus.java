package com.hcmus.mela.ai.chatbot.model;

import lombok.Getter;

@Getter
public enum ConversationStatus {
    UNIDENTIFIED,
    PROBLEM_IDENTIFIED,
    SUBMISSION_REVIEWED,
    SOLUTION_PROVIDED,
    COMPLETED,
}
