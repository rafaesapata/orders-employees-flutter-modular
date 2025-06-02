import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureNotFound extends RestFailure {
  RestFailureNotFound({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
