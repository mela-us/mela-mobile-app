package com.hcmus.mela.ai.chatbot.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GetListMessagesRequestDto {
    /**
     * A cursor for use in pagination. 'after' is an object ID that defines your place in the list.
     * For instance, if you make a list request and receive 100 objects, ending with obj_foo,
     * your subsequent call can include after=obj_foo in order to fetch the next page of the list.
     */
    private String after;

    /**
     * A cursor for use in pagination. 'before' is an object ID that defines your place in the list.
     * For instance, if you make a list request and receive 100 objects, starting with obj_foo,
     * your subsequent call can include before=obj_foo in order to fetch the previous page of the list.
     */
    private String before;

    /**
     * A limit on the number of objects to be returned.
     * Limit can range between 1 and 100.
     * Default: 20
     */
    @Min(value = 1, message = "Limit must be at least 1")
    @Max(value = 100, message = "Limit must not exceed 100")
    private int limit = 20;
}
