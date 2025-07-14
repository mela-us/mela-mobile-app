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
    //print("Vao onRequest AuthInterceptor");
    final String token = await accessToken() ?? '';
    //print("--------------------->Token: $token");
    if (token.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    super.onRequest(options, handler);
  }
}