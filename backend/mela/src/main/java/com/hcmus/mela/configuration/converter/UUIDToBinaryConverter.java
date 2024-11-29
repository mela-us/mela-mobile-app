package com.hcmus.mela.configuration.converter;

import org.bson.types.Binary;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.nio.ByteBuffer;
import java.util.UUID;

@Component
public class UUIDToBinaryConverter implements Converter<UUID, Binary> {

    @Override
    public Binary convert(UUID source) {
        ByteBuffer byteBuffer = ByteBuffer.allocate(16);
        byteBuffer.putLong(source.getMostSignificantBits());
        byteBuffer.putLong(source.getLeastSignificantBits());
        byte[] uuidBytes = byteBuffer.array();

        return new Binary((byte) 4, uuidBytes);
    }
}
