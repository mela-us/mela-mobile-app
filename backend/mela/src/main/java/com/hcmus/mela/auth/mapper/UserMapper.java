package com.hcmus.mela.auth.mapper;

import com.hcmus.mela.auth.dto.request.RegistrationRequest;
import com.hcmus.mela.auth.dto.dto.AuthenticatedUserDto;
import com.hcmus.mela.auth.model.User;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {

    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    User convertToUser(RegistrationRequest registrationRequest);

    AuthenticatedUserDto convertToAuthenticatedUserDto(User user);

    User convertToUser(AuthenticatedUserDto authenticatedUserDto);

}
