import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '956797993013-m0knscu6c9j13l6vv7e42u9phrvrd6ho.apps.googleusercontent.com', // Client ID cho iOS
    scopes: ['email', 'profile'], 
  );

  Future<void> handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Người dùng hủy đăng nhập');
        return;
      }

      // Lấy thông tin xác thực
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      print('ID Token: $idToken');
      print('Access Token: $accessToken');

      // Gửi idToken tới Backend
      await sendTokenToBackend(idToken);
    } catch (error) {
      print('Lỗi đăng nhập: $error');
    }
  }

  Future<void> sendTokenToBackend(String? idToken) async {
    print('Gửi token tới BE: $idToken');
  }
}