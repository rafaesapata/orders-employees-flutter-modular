import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureBadRequest extends RestFailure {
  RestFailureBadRequest({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
