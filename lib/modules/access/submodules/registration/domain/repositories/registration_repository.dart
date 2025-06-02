import 'package:result_dart/result_dart.dart';

import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/registration_dto.dart';

abstract class RegistrationRepository {
  AsyncResult<Unit, RestFailure> register(RegistrationDTO registration);
}
