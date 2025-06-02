import 'package:dio/dio.dart';

import '../../../../data/providers/network/network_info_provider.dart';
import '../failures/rest_failure_network_failure.dart';

class RestInterceptorNetwork extends Interceptor {
  final NetworkInfoProvider _networkInfo;

  RestInterceptorNetwork({
    required NetworkInfoProvider networkInfo,
  }) : _networkInfo = networkInfo;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await _networkInfo.isConnected();
    return result
        ? handler.next(options)
        : handler.reject(RestFailureNetworkFailure());
  }
}
