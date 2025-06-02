import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

import '../../../shared/submodules/firebase/domain/enums/firebase_feature_flag_enum.dart';
import '../../../shared/submodules/firebase/domain/usecases/firebase_get_feature_flag_usecase.dart';

enum AccessPageState { loading, ready, error, success, empty }

abstract class AccessController extends ChangeNotifier {
  ValueNotifier<bool> get featureFlagRegistration;
  Future<void> initialize();
}

class AccessControllerImp extends AccessController {
  final FirebaseGetFeatureFlagUsecase _featureFlagUsecase;

  @override
  final featureFlagRegistration = ValueNotifier(true);

  AccessControllerImp({
    required FirebaseGetFeatureFlagUsecase featureFlagUsecase,
  }) : _featureFlagUsecase = featureFlagUsecase;

  @override
  Future<void> initialize() async {
    featureFlagRegistration.value =
        await _featureFlagUsecase(FirebaseFeatureFlagEnum.registration)
            .getOrDefault(false);
  }
}
