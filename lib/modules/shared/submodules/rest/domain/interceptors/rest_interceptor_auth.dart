import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../data/providers/storage/session_provider.dart';

class RestInterceptorAuth extends Interceptor {
  final SessionProvider _sessionProvider;

  RestInterceptorAuth({
    required SessionProvider sessionProvider,
  }) : _sessionProvider = sessionProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await getAccessToken();
      if (token != null) {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      } else if (options.headers.containsKey(HttpHeaders.authorizationHeader)) {
        options.headers.remove(HttpHeaders.authorizationHeader);
      }
    } catch (e) {
      options.headers.remove(HttpHeaders.authorizationHeader);
    }
    return handler.next(options);
  }

  Future<String?> getAccessToken() async {
    var session = await _sessionProvider.get();
    return session?.token;
  }
}
