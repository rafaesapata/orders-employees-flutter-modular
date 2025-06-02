import 'package:result_dart/result_dart.dart';

import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../../domain/dtos/confirm_account_dto.dart';
import '../../domain/repositories/confirm_account_repository.dart';
import '../datasources/confirm_account_datasource.dart';

class ConfirmAccountRepositoryImp implements ConfirmAccountRepository {
  final ConfirmAccountDatasource _confirmAccountDatasource;

  ConfirmAccountRepositoryImp({
    required ConfirmAccountDatasource confirmAccountDatasource,
  }) : _confirmAccountDatasource = confirmAccountDatasource;

  @override
  AsyncResult<Unit, RestFailure> confirmAccount(
      ConfirmAccountDTO request) async {
    try {
      await _confirmAccountDatasource.confirmAccount(request);
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }

  @override
  AsyncResult<Unit, RestFailure> resendCode() async {
    try {
      await _confirmAccountDatasource.resendCode();
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }
}
