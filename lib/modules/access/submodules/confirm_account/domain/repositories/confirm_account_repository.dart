import 'package:result_dart/result_dart.dart';

import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/confirm_account_dto.dart';

abstract class ConfirmAccountRepository {
  AsyncResult<Unit, RestFailure> confirmAccount(ConfirmAccountDTO request);
  AsyncResult<Unit, RestFailure> resendCode();
}
