import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../../../app/app_config.dart';
import '../../../../data/providers/storage/session_provider.dart';
import '../../domain/entities/rest_response_entity.dart';
import '../../domain/interceptors/rest_interceptor_auth.dart';
import '../../domain/interceptors/rest_interceptor_failure.dart';
import '../models/rest_response_model.dart';

abstract class RestProvider {
  Future<RestResponseEntity<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestResponseEntity<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestResponseEntity<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestResponseEntity<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestResponseEntity<T>> path<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestResponseEntity<T>> request<T>(
    String url, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<RestResponseEntity<T>> download<T>(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    ResponseType? responseType,
    bool? followRedirects,
    Duration? receiveTimeout,
  });
}

class RestProviderImp implements RestProvider {
  late final Dio _dio;
  final SessionProvider _sessionProvider;

  BaseOptions _defaultOptions() => BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      );

  RestProviderImp({
    required SessionProvider sessionProvider,
  }) : _sessionProvider = sessionProvider {
    final interceptorList = [
      RestInterceptorFailure(sessionProvider: _sessionProvider),
      RestInterceptorAuth(sessionProvider: _sessionProvider),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: false,
        enabled: const bool.fromEnvironment('DIO_LOG_ENABLED'),
      ),
    ];
    _dio = Dio(_defaultOptions());
    _dio.interceptors.addAll(interceptorList);
  }

  @override
  Future<RestResponseEntity<T>> delete<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestResponseEntity<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestResponseEntity<T>> path<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestResponseEntity<T>> post<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestResponseEntity<T>> put<T>(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<RestResponseEntity<T>> request<T>(
    String url, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }

  RestResponseEntity<T> _dioResponseConverter<T>(
    Response<dynamic> response,
  ) =>
      RestResponseModel<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );

  @override
  Future<RestResponseEntity<T>> download<T>(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    ResponseType? responseType,
    bool? followRedirects,
    Duration? receiveTimeout,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        cancelToken: cancelToken,
        data: data,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          responseType: responseType,
          followRedirects: followRedirects,
          receiveTimeout: receiveTimeout,
        ),
      );

      return _dioResponseConverter(response);
    } on DioException {
      rethrow;
    }
  }
}
