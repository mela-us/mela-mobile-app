import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/data/network/dio/configs/dio_configs.dart';

class DioClient {
  // dio instance
  final Dio _dio;
  final DioConfigs dioConfigs;

  // injecting dio instance
  DioClient({required this.dioConfigs})
      : _dio = Dio()
          ..options.baseUrl = dioConfigs.baseUrl
          ..options.connectTimeout =
              Duration(milliseconds: dioConfigs.connectionTimeout)
          ..options.receiveTimeout =
              Duration(milliseconds: dioConfigs.receiveTimeout);

  Dio get dio => _dio;

  Dio addInterceptors(Iterable<Interceptor> interceptors) {
    print("------------>DioClient: addInterceptors");
    return _dio..interceptors.addAll(interceptors);
  }

  //Until
  ResponseStatus getResponseStatus(int? statusCode) {
    if (statusCode == 401) {
      return ResponseStatus.UNAUTHORIZED;
    }
    if (statusCode == 400) {
      return ResponseStatus.BAD_REQUEST;
    }
    //....
    return ResponseStatus.UNKNOWN;
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      //print('\n=== REQUEST INFO ===');
      // print('URL: ${_dio.options.baseUrl}$uri');
      // print('Method: GET');
      // print('Headers: ${_dio.options.headers}');
      // print('Query Parameters: $queryParameters');
      // print('Options: ${options?.toString()}');
      //_dio.options.headers['Content-Type'] = 'application/json';
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      // print("------------>DioClient: get luc sau");
      // print("Actual Request Headers: ${response.requestOptions.headers}");
      //print(response.data);

      if (response.statusCode != 200) {
        throw getResponseStatus(response.statusCode);
      }
      //200 OK
      return response.data;
    } catch (e) {
      //cat error above or other exception dio eg timeout....
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      // //Only for register account
      // if (response.statusCode == 201) {
      //   return response.data;
      // }
      // if (response.statusCode != 200) {
      //   throw getResponseStatus(response.statusCode);
      // }
      return response.data;
    } catch (e) {
      //cat unauthorized above or other exception dio eg timeout...
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
