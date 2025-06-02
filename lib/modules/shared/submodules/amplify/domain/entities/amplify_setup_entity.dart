abstract class AmplifySetupEntity {
  final String identityPoolId;
  final String poolId;
  final String appClientId;
  final String region;
  final String clientDomain;

  AmplifySetupEntity({
    required this.identityPoolId,
    required this.poolId,
    required this.appClientId,
    required this.region,
    required this.clientDomain,
  });
}
