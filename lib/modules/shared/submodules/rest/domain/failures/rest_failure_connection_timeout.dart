import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureConnectionTimeout extends RestFailure {
  RestFailureConnectionTimeout({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
