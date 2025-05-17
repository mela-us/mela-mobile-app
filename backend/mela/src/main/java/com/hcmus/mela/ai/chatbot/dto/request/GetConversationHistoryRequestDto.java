package com.hcmus.mela.ai.chatbot.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class GetConversationHistoryRequestDto {

    private Date updatedAtAfter;

    private Date updatedAtBefore;

    /**
     * A limit on the number of objects to be returned.
     * Limit can range between 1 and 100.
     * Default: 20
     */
    @Min(value = 1, message = "Limit must be at least 1")
    @Max(value = 100, message = "Limit must not exceed 100")
    private int limit = 20;

    /**
     * Sort order by the updatedAt timestamp of the objects.
     * Accepted values: "asc" for ascending order and "desc" for descending order.
     * Default: "desc"
     */
    @Pattern(regexp = "^(asc|desc)$", message = "Order must be either 'asc' or 'desc'")
    private String order = "desc";
}
