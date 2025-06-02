import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../repositories/firebase_repository.dart';

abstract class FirebaseInitializeUsecase extends SharedBaseUsecase {}

class FirebaseInitializeUsecaseImp implements FirebaseInitializeUsecase {
  final FirebaseRepository _firebaseRepository;

  FirebaseInitializeUsecaseImp({
    required FirebaseRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository;

  @override
  AsyncResult<Unit, RestFailure> call() async =>
      await _firebaseRepository.initializeFirebase();
}
