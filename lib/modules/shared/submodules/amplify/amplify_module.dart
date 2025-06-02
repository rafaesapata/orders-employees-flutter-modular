import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/amplify_datasource.dart';
import 'data/datasources/local/amplify_datasource_imp.dart';
import 'data/repositories/amplify_repository_imp.dart';
import 'domain/repositories/amplify_repository.dart';
import 'domain/usecases/amplify_get_is_logged_usecase.dart';
import 'domain/usecases/amplify_get_session_usecase.dart';
import 'domain/usecases/amplify_get_token_usecase.dart';
import 'domain/usecases/amplify_initialize_cognito_usecase.dart';
import 'domain/usecases/amplify_sign_in_cognito_usecase.dart';
import 'domain/usecases/amplify_sign_out_usecase.dart';

class AmplifyModule extends Module {
  @override
  void exportedBinds(Injector i) {
    // Datasources
    i.addLazySingleton<AmplifyDatasource>(AmplifyDatasourceImp.new);

    // Repositories
    i.addLazySingleton<AmplifyRepository>(AmplifyRepositoryImp.new);

    // Usecases
    i.addLazySingleton<AmplifyGetIsLoggedUsecase>(
        AmplifyGetIsLoggedUsecaseImp.new);
    i.addLazySingleton<AmplifyGetSessionUsecase>(
        AmplifyGetSessionUsecaseImp.new);
    i.addLazySingleton<AmplifyGetTokenUsecase>(AmplifyGetTokenUsecaseImp.new);
    i.addLazySingleton<AmplifyInitializeCognitoUsecase>(
        AmplifyInitializeCognitoUsecaseImp.new);
    i.addLazySingleton<AmplifySignInCognitoUsecase>(
        AmplifySignInCognitoUsecaseImp.new);
    i.addLazySingleton<AmplifySignOutUsecase>(AmplifySignOutUsecaseImp.new);

    super.exportedBinds(i);
  }
}
