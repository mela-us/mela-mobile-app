package com.hcmus.mela.dto.service;

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
