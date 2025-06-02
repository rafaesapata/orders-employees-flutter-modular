import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/firebase_datasource.dart';
import 'data/datasources/remote/firebase_datasource_imp.dart';
import 'data/provider/firebase_crashlytics_provider.dart';
import 'data/provider/firebase_push_notification_provider.dart';
import 'data/provider/firebase_remote_config_provider.dart';
import 'data/repositories/firebase_repository_imp.dart';
import 'domain/repositories/firebase_repository.dart';
import 'domain/usecases/firebase_get_feature_flag_usecase.dart';
import 'domain/usecases/firebase_get_push_tokey_usecase.dart';
import 'domain/usecases/firebase_initialize_usecase.dart';

class FirebaseModule extends Module {
  @override
  void exportedBinds(Injector i) {
    // Providers
    i.addLazySingleton(FirebaseCrashlyticsProvider.new);
    i.addLazySingleton(FirebaseRemoteConfigProvider.new);
    i.addLazySingleton(FirebasePushNotificationProvider.new);

    // Datasources
    i.addLazySingleton<FirebaseDatasource>(FirebaseDatasourceImp.new);

    // Repositories
    i.addLazySingleton<FirebaseRepository>(FirebaseRepositoryImp.new);

    // Usecases
    i.addLazySingleton<FirebaseInitializeUsecase>(
        FirebaseInitializeUsecaseImp.new);
    i.addLazySingleton<FirebaseGetPushTokeyUsecase>(
        FirebaseGetPushTokeyUsecaseImp.new);
    i.addLazySingleton<FirebaseGetFeatureFlagUsecase>(
        FirebaseGetFeatureFlagUsecaseImp.new);

    super.exportedBinds(i);
  }
}
