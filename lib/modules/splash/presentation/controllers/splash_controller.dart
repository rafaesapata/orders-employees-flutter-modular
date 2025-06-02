import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../access/access_routes.dart';
import '../../../onboarding/onboarding_routes.dart';
import '../../../shared/domain/enums/shared_enum_prefs_keys.dart';
import '../../../shared/submodules/amplify/domain/usecases/amplify_get_is_logged_usecase.dart';
import '../../../shared/submodules/amplify/domain/usecases/amplify_initialize_cognito_usecase.dart';
import '../../../shared/submodules/firebase/domain/usecases/firebase_initialize_usecase.dart';
import '../../../home/home_routes.dart';
import '../../../shared/domain/usecases/shared_fetch_local_user_usecase.dart';

abstract class SplashController extends ChangeNotifier {
  Future<String> init();
}

class SplashControllerImp extends SplashController {
  final FirebaseInitializeUsecase _firebaseInitializeUsecase;
  final AmplifyInitializeCognitoUsecase _amplifyInitializeCognitoUsecase;
  final AmplifyGetIsLoggedUsecase _amplifyGetIsLoggedUsecase;
  final SharedFetchLocalUserUseCase _fetchLocalUserDataUseCase;

  SplashControllerImp({
    required FirebaseInitializeUsecase firebaseInitializeUsecase,
    required AmplifyInitializeCognitoUsecase amplifyInitializeCognitoUsecase,
    required AmplifyGetIsLoggedUsecase amplifyGetIsLoggedUsecase,
    required SharedFetchLocalUserUseCase fetchLocalUserDataUseCase,
  })  : _firebaseInitializeUsecase = firebaseInitializeUsecase,
        _amplifyInitializeCognitoUsecase = amplifyInitializeCognitoUsecase,
        _amplifyGetIsLoggedUsecase = amplifyGetIsLoggedUsecase,
        _fetchLocalUserDataUseCase = fetchLocalUserDataUseCase;

  late final SharedPreferences _sharedPreferences;

  @override
  Future<String> init() async {
    await _initializeFirebase();
    await _initializeAmplify();
    return _proceedToNextPage();
  }

  Future<bool> _initializeFirebase() async {
    final result = await _firebaseInitializeUsecase();
    return result.fold(
      (success) => true,
      (failure) => false,
    );
  }

  Future<bool> _initializeAmplify() async {
    final result = await _amplifyInitializeCognitoUsecase();
    return result.fold(
      (success) => true,
      (failure) => false,
    );
  }

  Future<String> _proceedToNextPage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final onboardingDone = _sharedPreferences.getBool(
      SharedEnumPrefsKeys.onboardingDoneKey.key,
    );
    if (onboardingDone != true) {
      return OnboardingRoutes.onboarding;
    } else {
      final result = await _amplifyGetIsLoggedUsecase().getOrDefault(false);
      final userResult = await _fetchLocalUserDataUseCase().getOrNull();
      return result && userResult != null
          ? HomeRoutes.home
          : AccessRoutes.access;
    }
  }
}
