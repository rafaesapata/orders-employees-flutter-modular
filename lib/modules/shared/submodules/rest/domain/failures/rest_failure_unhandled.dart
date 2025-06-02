import 'package:dio/dio.dart';

import '../../../../../../app/app_localization.dart';
import 'rest_failure.dart';

class RestFailureUnhandled extends RestFailure {
  RestFailureUnhandled({
    String? message,
    String? code,
    Response<dynamic>? response,
    RequestOptions? requestOptions,
  }) : super(
          code: null,
          message: Localization.tr.unhandledFailureMessage,
          response: response ?? Response(requestOptions: RequestOptions()),
          requestOptions: requestOptions ?? RequestOptions(),
        );
}
