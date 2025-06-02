import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureUnauthorized extends RestFailure {
  RestFailureUnauthorized({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
