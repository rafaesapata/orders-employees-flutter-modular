import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureUserNotAllowed extends RestFailure {
  RestFailureUserNotAllowed({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
