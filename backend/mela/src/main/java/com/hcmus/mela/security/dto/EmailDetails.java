package com.hcmus.mela.security.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class EmailDetails {
    private String recipient;

    private String msgBody;

    private String subject;
}
