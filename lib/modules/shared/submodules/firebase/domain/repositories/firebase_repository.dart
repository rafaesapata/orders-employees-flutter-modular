import 'package:result_dart/result_dart.dart';

import '../../../rest/domain/failures/rest_failure.dart';
import '../enums/firebase_feature_flag_enum.dart';

abstract class FirebaseRepository {
  AsyncResult<Unit, RestFailure> initializeFirebase();
  AsyncResult<String, RestFailure> getPushToken();
  AsyncResult<bool, RestFailure> getFeatureFlag(
    FirebaseFeatureFlagEnum feature,
  );
}
