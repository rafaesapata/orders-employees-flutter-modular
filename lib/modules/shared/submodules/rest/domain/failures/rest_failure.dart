import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../../../../app/app_localization.dart';
import 'rest_failure_bad_request.dart';
import 'rest_failure_connection_timeout.dart';
import 'rest_failure_forbidden.dart';
import 'rest_failure_network_failure.dart';
import 'rest_failure_not_found.dart';
import 'rest_failure_server_failure.dart';
import 'rest_failure_unauthorized.dart';
import 'rest_failure_unhandled.dart';

abstract class RestFailure extends DioException {
  final String? code;

  RestFailure({
    required super.message,
    this.code,
    required super.requestOptions,
    required super.response,
  });

  static RestFailure fromDioException(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    final data = error.response?.data;
    String? message;
    String? code;

    if (data is Map<String, dynamic> && data.containsKey('code')) {
      code = data['code'].toString();
    }

    if (data is Map<String, dynamic> && data.containsKey('message')) {
      message = data['message'];
    } else if (data is String) {
      message = data;
    } else {
      message = Localization.tr.networkFailureMessage;
    }

    log(
      {
        'code': code,
        'message': message,
        'statusCode': error.response?.statusCode,
        'responseData': error.response?.data,
        'DioExceptionType': error.type.toString(),
      }.toString(),
      name: 'CoreFailure',
    );

    if (error.type == DioExceptionType.connectionError) {
      return RestFailureNetworkFailure(
        code: code,
        requestOptions: error.requestOptions,
        response: error.response,
      );
    }

    if (error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionTimeout) {
      return RestFailureConnectionTimeout(
        code: code,
        message: message,
        requestOptions: error.requestOptions,
        response: error.response,
      );
    }

    /// Erros de negócio mapeado no backend e na documentação
    /// Aqui você, na sua aplicação, pode definir erros exclusivos para seu APP e tratar aqui.
    if (code != null) {
      switch (code) {}
    }

    /// Erros baseados no statusCode
    switch (statusCode) {
      case 400:
        return RestFailureBadRequest(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      case 401:
        return RestFailureUnauthorized(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      case 403:
        return RestFailureForbidden(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      case 404:
        return RestFailureNotFound(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      case 500:
        return RestFailureServerFailure(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      case 503:
        return RestFailureServerFailure(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      case 504:
        return RestFailureServerFailure(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
      default:
        return RestFailureUnhandled(
          code: code,
          message: message,
          requestOptions: error.requestOptions,
          response: error.response,
        );
    }
  }

  static RestFailure fromError({required Object e, StackTrace? stackTrace}) {
    log(
      {
        'method': 'fromError',
        'error': e.toString(),
      }.toString(),
      name: 'CoreFailure',
      stackTrace: stackTrace,
    );

    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return RestFailureUnhandled();
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
      };
}
