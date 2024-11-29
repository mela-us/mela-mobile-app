package com.hcmus.mela.configuration.converter;

import org.bson.types.Binary;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.nio.ByteBuffer;
import java.util.UUID;

@Component
public class BinaryToUUIDConverter implements Converter<Binary, UUID> {

    @Override
    public UUID convert(Binary source) {
        byte[] bytes = source.getData();

        ByteBuffer bb = ByteBuffer.wrap(bytes);
        long mostSigBits = bb.getLong();
        long leastSigBits = bb.getLong();
        return new UUID(mostSigBits, leastSigBits);
    }
}
