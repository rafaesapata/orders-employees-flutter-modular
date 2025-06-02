import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../enums/firebase_feature_flag_enum.dart';
import '../repositories/firebase_repository.dart';

abstract class FirebaseGetFeatureFlagUsecase
    extends SharedBaseUsecaseInputOutput<FirebaseFeatureFlagEnum, bool> {}

class FirebaseGetFeatureFlagUsecaseImp
    implements FirebaseGetFeatureFlagUsecase {
  final FirebaseRepository _firebaseRepository;

  FirebaseGetFeatureFlagUsecaseImp({
    required FirebaseRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository;

  @override
  AsyncResult<bool, RestFailure> call(FirebaseFeatureFlagEnum feature) async =>
      await _firebaseRepository.getFeatureFlag(feature);
}
