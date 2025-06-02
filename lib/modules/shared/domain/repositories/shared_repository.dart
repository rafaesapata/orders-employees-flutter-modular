import 'package:result_dart/result_dart.dart';

import '../../submodules/rest/domain/failures/rest_failure.dart';
import '../entities/user_entity.dart';

abstract class SharedRepository {
  AsyncResult<UserEntity, RestFailure> fetchRemoteUserData();
  AsyncResult<UserEntity, RestFailure> fetchLocalUserData();
  AsyncResult<bool, RestFailure> requestStoragePermission();
}
