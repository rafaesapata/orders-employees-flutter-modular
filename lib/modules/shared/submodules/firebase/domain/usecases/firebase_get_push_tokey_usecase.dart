import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../repositories/firebase_repository.dart';

abstract class FirebaseGetPushTokeyUsecase
    extends SharedBaseUsecaseOutput<String> {}

class FirebaseGetPushTokeyUsecaseImp extends FirebaseGetPushTokeyUsecase {
  final FirebaseRepository _firebaseRepository;

  FirebaseGetPushTokeyUsecaseImp({
    required FirebaseRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository;

  @override
  AsyncResult<String, RestFailure> call() async =>
      await _firebaseRepository.getPushToken();
}
