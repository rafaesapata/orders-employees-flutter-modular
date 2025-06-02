import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureSessionNotFound extends RestFailure {
  RestFailureSessionNotFound({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
