import 'package:result_dart/result_dart.dart';

import '../../../../../shared/data/models/user_model.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/login_dto.dart';

abstract class LoginRepository {
  AsyncResult<UserModel, RestFailure> loginWithAPI({required LoginDTO login});
}
