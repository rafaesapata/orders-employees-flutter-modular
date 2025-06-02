import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../access/submodules/login/login_routes.dart';
import '../../../../data/providers/storage/session_provider.dart';
import '../failures/rest_failure.dart';

class RestInterceptorFailure extends Interceptor {
  final SessionProvider _sessionProvider;

  RestInterceptorFailure({
    required SessionProvider sessionProvider,
  }) : _sessionProvider = sessionProvider;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _sessionProvider.destroy();
      Modular.to.pushNamed(LoginRoutes.unauthorized);
      handler.reject(RestFailure.fromDioException(err));
      return;
    }

    handler.next(RestFailure.fromDioException(err));
  }
}
