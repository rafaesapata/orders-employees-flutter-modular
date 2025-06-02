import 'package:result_dart/result_dart.dart';

import '../../../rest/domain/failures/rest_failure.dart';
import '../../../rest/domain/failures/rest_failure_unhandled.dart';
import '../../domain/enums/firebase_feature_flag_enum.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../datasources/firebase_datasource.dart';
import '../provider/firebase_crashlytics_provider.dart';
import '../provider/firebase_push_notification_provider.dart';
import '../provider/firebase_remote_config_provider.dart';

class FirebaseRepositoryImp implements FirebaseRepository {
  final FirebaseDatasource _firebaseDatasource;
  final FirebaseCrashlyticsProvider _firebaseCrashlyticsProvider;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;
  final FirebasePushNotificationProvider _firebasePushNotificationProvider;

  FirebaseRepositoryImp({
    required FirebaseDatasource firebaseDatasource,
    required FirebaseCrashlyticsProvider firebaseCrashlyticsProvider,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
    required FirebasePushNotificationProvider firebasePushNotificationProvider,
  })  : _firebaseDatasource = firebaseDatasource,
        _firebaseCrashlyticsProvider = firebaseCrashlyticsProvider,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        _firebasePushNotificationProvider = firebasePushNotificationProvider;

  @override
  AsyncResult<Unit, RestFailure> initializeFirebase() async {
    try {
      await _firebaseDatasource.initialize();
      await _firebaseCrashlyticsProvider.initialize();
      await _firebaseRemoteConfigProvider.initialize();
      await _firebasePushNotificationProvider.initialize();
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<String, RestFailure> getPushToken() async {
    try {
      final result = await _firebasePushNotificationProvider.getPushToken();
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<bool, RestFailure> getFeatureFlag(
    FirebaseFeatureFlagEnum feature,
  ) async {
    try {
      final result = _firebaseRemoteConfigProvider.getBool(feature.value);
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }
}
