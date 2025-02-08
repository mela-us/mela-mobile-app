package com.hcmus.mela.user.service;

import com.hcmus.mela.user.dto.request.*;
import com.hcmus.mela.user.dto.response.*;

public interface UserService {
    UpdateProfileResponse updateProfile(UpdateProfileRequest updateProfileRequest, String authorizationHeader);

    GetUserProfileResponse getUserProfile(String authorizationHeader);

    void deleteAccount(DeleteAccountRequest deleteAccountRequest, String authorizationHeader);
}
