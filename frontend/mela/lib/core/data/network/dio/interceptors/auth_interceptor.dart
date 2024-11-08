import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
//Này là để đính kèm token vào header của request
class AuthInterceptor extends Interceptor {
  final AsyncValueGetter<String?> accessToken;

  AuthInterceptor({
    required this.accessToken,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String token = await accessToken() ?? '';
    if (token.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    super.onRequest(options, handler);
  }
}
