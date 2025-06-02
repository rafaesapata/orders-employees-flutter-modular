import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../app/app_module.dart';
import 'data/datasource/local/shared_datasource_imp.dart';
import 'data/datasource/shared_datasource.dart';
import 'data/providers/network/network_info_provider.dart';
import 'data/providers/storage/secure_storage_provider.dart';
import 'data/providers/storage/session_provider.dart';
import 'data/providers/storage/user_provider.dart';
import 'data/repositories/shared_repository_imp.dart';
import 'domain/repositories/shared_repository.dart';
import 'domain/usecases/shared_fetch_local_user_usecase.dart';
import 'domain/usecases/shared_fetch_remote_user_usecase.dart';
import 'domain/usecases/shared_get_local_image_usecase.dart';
import 'domain/usecases/shared_request_storage_permission_usecase.dart';
import 'submodules/amplify/amplify_module.dart';
import 'submodules/firebase/firebase_module.dart';
import 'submodules/rest/data/provider/rest_provider_imp.dart';
import 'submodules/rest/rest_module.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(Injector i) {
    // Providers
    i.addLazySingleton<NetworkInfoProvider>(
      () => NetworkInfoProviderImp(InternetConnectionChecker.createInstance()),
    );
    i.addLazySingleton<SecureStorageProvider>(
      () => SecureStorageProviderImp(storage: const FlutterSecureStorage()),
    );
    i.addLazySingleton<SessionProvider>(SessionProviderImp.new);
    i.addLazySingleton<UserProvider>(UserProviderImp.new);

    // Datasources
    i.addLazySingleton<SharedDatasource>(SharedDatasourceImp.new);

    // Repositories
    i.addLazySingleton<SharedRepository>(SharedRepositoryImp.new);

    //Usecases
    i.addLazySingleton<SharedFetchRemoteUserUseCase>(
        SharedFetchRemoteUserUseCaseImp.new);
    i.addLazySingleton<SharedFetchLocalUserUseCase>(
        SharedFetchLocalUserUseCaseImp.new);
    i.addLazySingleton<SharedGetLocalImageUsecase>(
        SharedGetLocalImageUsecaseImp.new);
    i.addLazySingleton<SharedRequestStoragePermissionUseCase>(
        SharedRequestStoragePermissionUseCaseImp.new);

    super.exportedBinds(i);
  }

  @override
  void binds(Injector i) {
    i.addSingleton<RestProvider>(RestProviderImp.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: AmplifyModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: FirebaseModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: RestModule(),
    );
    super.routes(r);
  }
}
