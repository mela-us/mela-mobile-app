import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/entity/user/user.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user_login/user_login_repository.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
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

class LoginUseCase implements UseCase<TokenModel?, LoginParams> {
  final UserLoginRepository _userLoginRepository;

  LoginUseCase(this._userLoginRepository);

  @override
  Future<TokenModel?> call({required LoginParams params}){
    
    return _userLoginRepository.login(params);
  }
}
