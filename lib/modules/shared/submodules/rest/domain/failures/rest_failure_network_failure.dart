import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureNetworkFailure extends RestFailure {
  RestFailureNetworkFailure({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
