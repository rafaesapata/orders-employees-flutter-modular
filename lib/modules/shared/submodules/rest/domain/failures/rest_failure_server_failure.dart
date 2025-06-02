import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureServerFailure extends RestFailure {
  RestFailureServerFailure({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
