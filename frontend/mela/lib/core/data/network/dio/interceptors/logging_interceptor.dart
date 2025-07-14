// library dio_logging_interceptor;

// import 'dart:convert';

// import 'package:dio/dio.dart';

// //Này là để ghi log ra console của Dio khi gửi request đi hoặc nhận response về
// /// Log Level
// enum Level {
//   /// No logs.
//   none,

//   /// Logs request and response lines.
//   ///
//   /// Example:
//   ///  ```
//   ///  --> POST /greeting
//   ///
//   ///  <-- 200 OK
//   ///  ```
//   basic,

//   /// Logs request and response lines and their respective headers.
//   ///
//   ///  Example:
//   /// ```
//   /// --> POST /greeting
//   /// Host: example.com
//   /// Content-Type: plain/text
//   /// Content-Length: 3
//   /// --> END POST
//   ///
//   /// <-- 200 OK
//   /// Content-Type: plain/text
//   /// Content-Length: 6
//   /// <-- END HTTP
//   /// ```
//   headers,

//   /// Logs request and response lines and their respective headers and bodies (if present).
//   ///
//   /// Example:
//   /// ```
//   /// --> POST /greeting
//   /// Host: example.com
//   /// Content-Type: plain/text
//   /// Content-Length: 3
//   ///
//   /// Hi?
//   /// --> END POST
//   ///
//   /// <-- 200 OK
//   /// Content-Type: plain/text
//   /// Content-Length: 6
//   ///
//   /// Hello!
//   /// <-- END HTTP
//   /// ```
//   body,
// }

// /// DioLoggingInterceptor
// /// Simple logging interceptor for dio.
// ///
// /// Inspired the okhttp-logging-interceptor and referred to pretty_dio_logger.
// class LoggingInterceptor extends Interceptor {
//   /// Log Level
//   final Level level;

//   /// Log printer; defaults logPrint log to console.
//   /// In flutter, you'd better use debugPrint.
//   /// you can also write log in a file.
//   void Function(Object object) logPrint;

//   /// Print compact json response
//   final bool compact;

//   final JsonDecoder decoder = const JsonDecoder();
//   final JsonEncoder encoder = const JsonEncoder.withIndent('  ');

//   LoggingInterceptor({
//     this.level = Level.body,
//     this.compact = false,
//     this.logPrint = print,
//   });

//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) {
//     if (level == Level.none) {
//       return handler.next(options);
//     }

//     logPrint('--> ${options.method} ${options.uri}');

//     if (level == Level.basic) {
//       return handler.next(options);
//     }

//     logPrint('[DIO][HEADERS]');
//     options.headers.forEach((key, value) {
//       logPrint('$key:$value');
//     });

//     if (level == Level.headers) {
//       logPrint('[DIO][HEADERS]--> END ${options.method}');
//       return handler.next(options);
//     }

//     final data = options.data;
//     if (data != null) {
//       // logPrint('[DIO]dataType:${data.runtimeType}');
//       if (data is Map) {
//         if (compact) {
//           logPrint('$data');
//         } else {
//           _prettyPrintJson(data);
//         }
//       } else if (data is FormData) {
//         // NOT IMPLEMENT
//       } else {
//         logPrint(data.toString());
//       }
//     }

//     logPrint('[DIO]--> END ${options.method}');

//     return handler.next(options);
//   }

//   @override
//   void onResponse(
//     Response response,
//     ResponseInterceptorHandler handler,
//   ) {
//     if (level == Level.none) {
//       return handler.next(response);
//     }

//     logPrint(
//         '<-- ${response.statusCode} ${(response.statusMessage?.isNotEmpty ?? false) ? response.statusMessage : '' '${response.requestOptions.uri}'}');

//     if (level == Level.basic) {
//       return handler.next(response);
//     }

//     logPrint('[DIO][HEADER]');
//     response.headers.forEach((key, value) {
//       logPrint('$key:$value');
//     });
//     logPrint('[DIO][HEADERS]<-- END ${response.requestOptions.method}');
//     if (level == Level.headers) {
//       return handler.next(response);
//     }
//     final data = response.data;
//     if (data != null) {
//       // logPrint('[DIO]dataType:${data.runtimeType}');
//       if (data is Map) {
//         if (compact) {
//           logPrint('$data');
//         } else {
//           _prettyPrintJson(data);
//         }
//       } else if (data is List) {
//         // NOT IMPLEMENT
//       } else {
//         logPrint(data.toString());
//       }
//     }

//     logPrint('[DIO]<-- END HTTP');
//     return handler.next(response);
//   }

//   @override
//   void onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) {
//     if (level == Level.none) {
//       return handler.next(err);
//     }

//     logPrint('[DIO]<-- HTTP FAILED: $err');
//     if (err.response?.data != null) {
//       logPrint('[DIO][ERROR RESPONSE]');
//       final data = err.response!.data;
//       if (data is Map) {
//         if (compact) {
//           logPrint('$data');
//         } else {
//           _prettyPrintJson(data);
//         }
//       } else {
//         logPrint(data.toString());
//       }
//     } else {
//       logPrint('[DIO]No response body available');
//     }

//     return handler.next(err);
//   }

//   void _prettyPrintJson(Object input) {
//     final prettyString = encoder.convert(input);
//     logPrint('<-- Response payload');
//     prettyString.split('\n').forEach((element) => logPrint(element));
//   }
// }

///Logging with color

library dio_logging_interceptor;

import 'dart:convert';

import 'package:dio/dio.dart';

class LogColor {
  static const String reset = '\x1B[0m';
  static const String blue = '\x1B[34m';
  static const String green = '\x1B[32m';
  static const String red = '\x1B[31m';
}

/// Log Level
enum Level {
  none,
  basic,
  headers,
  body,
}

/// DioLoggingInterceptor
/// Simple logging interceptor for dio.
class LoggingInterceptor extends Interceptor {
  final Level level;
  void Function(Object object) logPrint;
  final bool compact;

  final JsonDecoder decoder = const JsonDecoder();
  final JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  LoggingInterceptor({
    this.level = Level.body,
    this.compact = false,
    this.logPrint = print,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (level == Level.none) {
      return handler.next(options);
    }

    // In request với màu xanh dương
    logPrint(
        '${LogColor.blue}--> ${options.method} ${options.uri}${LogColor.reset}');

    if (level == Level.basic) {
      return handler.next(options);
    }

    logPrint('${LogColor.blue}[DIO][HEADERS]${LogColor.reset}');
    options.headers.forEach((key, value) {
      logPrint('${LogColor.blue}$key:$value${LogColor.reset}');
    });

    if (level == Level.headers) {
      logPrint(
          '${LogColor.blue}[DIO][HEADERS]--> END ${options.method}${LogColor.reset}');
      return handler.next(options);
    }

    final data = options.data;
    if (data != null) {
      if (data is Map) {
        if (compact) {
          logPrint('${LogColor.blue}$data${LogColor.reset}');
        } else {
          _prettyPrintJson(data, color: LogColor.blue);
        }
      } else if (data is FormData) {
        // NOT IMPLEMENT
      } else {
        logPrint('${LogColor.blue}$data${LogColor.reset}');
      }
    }

    logPrint('${LogColor.blue}[DIO]--> END ${options.method}${LogColor.reset}');
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (level == Level.none) {
      return handler.next(response);
    }

    // In response với màu xanh lá
    logPrint(
        '${LogColor.green}<-- ${response.statusCode} ${(response.statusMessage?.isNotEmpty ?? false) ? response.statusMessage : ''} ${response.requestOptions.uri}${LogColor.reset}');

    if (level == Level.basic) {
      return handler.next(response);
    }

    logPrint('${LogColor.green}[DIO][HEADER]${LogColor.reset}');
    response.headers.forEach((key, value) {
      logPrint('${LogColor.green}$key:$value${LogColor.reset}');
    });
    logPrint(
        '${LogColor.green}[DIO][HEADERS]<-- END ${response.requestOptions.method}${LogColor.reset}');

    if (level == Level.headers) {
      return handler.next(response);
    }

    final data = response.data;
    if (data != null) {
      if (data is Map) {
        if (compact) {
          logPrint('${LogColor.green}$data${LogColor.reset}');
        } else {
          _prettyPrintJson(data, color: LogColor.green);
        }
      } else if (data is List) {
        // NOT IMPLEMENT
      } else {
        logPrint('${LogColor.green}$data${LogColor.reset}');
      }
    }

    logPrint('${LogColor.green}[DIO]<-- END HTTP${LogColor.reset}');
    return handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (level == Level.none) {
      return handler.next(err);
    }

    // In lỗi với màu đỏ
    logPrint('${LogColor.red}[DIO]<-- HTTP FAILED: $err${LogColor.reset}');

    if (err.response?.data != null) {
      logPrint('${LogColor.red}[DIO][ERROR RESPONSE]${LogColor.reset}');
      final data = err.response!.data;
      if (data is Map) {
        if (compact) {
          logPrint('${LogColor.red}$data${LogColor.reset}');
        } else {
          _prettyPrintJson(data, color: LogColor.red);
        }
      } else {
        logPrint('${LogColor.red}$data${LogColor.reset}');
      }
    } else {
      logPrint(
          '${LogColor.red}[DIO]No response body available${LogColor.reset}');
    }

    return handler.next(err);
  }

  void _prettyPrintJson(Object input, {String color = LogColor.reset}) {
    final prettyString = encoder.convert(input);
    logPrint('${color}<-- Response payload${LogColor.reset}');
    prettyString
        .split('\n')
        .forEach((element) => logPrint('$color$element${LogColor.reset}'));
  }
}
