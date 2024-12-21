package com.hcmus.mela.auth.dto.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class EmailDetailsDto {
    private String recipient;

    private String msgBody;

    private String subject;
}
