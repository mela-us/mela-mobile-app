package com.hcmus.mela.user.service;

import com.hcmus.mela.user.dto.request.*;
import com.hcmus.mela.user.dto.response.*;
import com.hcmus.mela.user.model.User;

public interface UserService {
    UpdateProfileResponse updateProfile(UpdateProfileRequest updateProfileRequest, String authorizationHeader);

    GetUserProfileResponse getUserProfile(String authorizationHeader);
}
