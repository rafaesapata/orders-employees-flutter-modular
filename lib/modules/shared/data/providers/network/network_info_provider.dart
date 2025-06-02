import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../submodules/rest/domain/failures/rest_failure_network_failure.dart';

abstract class NetworkInfoProvider {
  Future<bool> isConnected();
}

class NetworkInfoProviderImp implements NetworkInfoProvider {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoProviderImp(this.connectionChecker);

  @override
  Future<bool> isConnected() async {
    final hasConnection = await connectionChecker.hasConnection;
    if (!hasConnection) {
      throw RestFailureNetworkFailure();
    }
    return hasConnection;
  }
}
