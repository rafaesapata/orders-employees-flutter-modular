import 'package:dio/dio.dart';

import 'rest_failure.dart';

class RestFailureForbidden extends RestFailure {
  RestFailureForbidden({
    super.message,
    super.code,
    RequestOptions? requestOptions,
    super.response,
  }) : super(requestOptions: requestOptions ?? RequestOptions());
}
