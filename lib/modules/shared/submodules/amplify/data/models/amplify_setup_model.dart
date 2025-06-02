import '../../../../../../app/app_config.dart';
import '../../domain/entities/amplify_setup_entity.dart';

class AmplifySetupModel extends AmplifySetupEntity {
  AmplifySetupModel({
    required super.identityPoolId,
    required super.poolId,
    required super.appClientId,
    required super.region,
    required super.clientDomain,
  });

  factory AmplifySetupModel.start() => AmplifySetupModel(
        identityPoolId: '', // Não necessário para autenticação básica
        poolId: AppConfig.cognitoPoolId,
        appClientId: AppConfig.cognitoClientId,
        region: AppConfig.cognitoRegion,
        clientDomain: AppConfig.cognitoClientDomain,
      );
}
