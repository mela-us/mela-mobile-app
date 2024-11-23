import 'dart:async';

import 'package:mela/domain/repository/user_register/user_signup_repostiory.dart';

import '../../../core/domain/usecase/use_case.dart';

class SignupParams {
  final String username;
  final String password;

  SignupParams({required this.username, required this.password});
  factory SignupParams.fromJson(Map<String, dynamic> json) {
    return SignupParams(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class SignupUseCase implements UseCase<void, SignupParams>{
  final UserSignUpRepository _userSignUpRepository;

  SignupUseCase(this._userSignUpRepository);
  
  @override
  Future<void> call({required SignupParams params}) {
    return _userSignUpRepository.signup(params);
  }



  
}