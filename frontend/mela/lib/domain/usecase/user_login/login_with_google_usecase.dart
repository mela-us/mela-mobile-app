import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/repository/user_login/user_login_repository.dart';

class LoginWithGoogleParams {
  final String? idToken;
  final String? accessToken;

  LoginWithGoogleParams({required this.idToken, required this.accessToken});

  factory LoginWithGoogleParams.fromJson(Map<String, dynamic> json) {
    return LoginWithGoogleParams(
      idToken: json['idToken'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'accessToken': accessToken,
    };
  }
}

class LoginWithGoogleUseCase
    implements UseCase<TokenModel?, LoginWithGoogleParams> {
  final UserLoginRepository _userLoginRepository;

  LoginWithGoogleUseCase(this._userLoginRepository);

  @override
  Future<TokenModel?> call({required LoginWithGoogleParams params}) {
    print("==============Login With Google");
    print(params.toJson());

    return _userLoginRepository.loginWithGoogle(params);
  }
}
