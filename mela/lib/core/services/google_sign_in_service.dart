import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:mela/domain/usecase/user_login/login_with_google_usecase.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: defaultTargetPlatform == TargetPlatform.iOS
        ? '956797993013-m0knscu6c9j13l6vv7e42u9phrvrd6ho.apps.googleusercontent.com' //ClientId của iOS
        : null, //ClientId của Android not need
    serverClientId:
        "956797993013-pual4qqrmk53h7td9b0j1q9codphkujl.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  Future<LoginWithGoogleParams?> handleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Người dùng hủy đăng nhập');
        return null;
      }

      // Lấy thông tin xác thực
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      print('ID Token: $idToken');
      print('Access Token: $accessToken');

      return LoginWithGoogleParams(idToken: idToken, accessToken: accessToken);
    } catch (error) {
      print('Lỗi đăng nhập: $error');
      throw "Có lỗi xảy ra, vui lòng thử lại sau";
    }
  }
}
