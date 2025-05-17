package com.hcmus.mela.auth.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "otps")
public class Otp {

    @Id
    @Field(name = "_id")
    private UUID otpId;

    @Field("otp_code")
    private String otpCode;

    @Field("expired_at")
    private Date expireAt;

    @Field(name = "user_id")
    private UUID userId;
}
