import 'package:result_dart/result_dart.dart';

import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../../domain/dtos/registration_dto.dart';
import '../../domain/repositories/registration_repository.dart';
import '../datasources/registration_datasource.dart';

class RegistrationRepositoryImp implements RegistrationRepository {
  final RegistrationDatasource _registrationDatasource;

  RegistrationRepositoryImp({
    required RegistrationDatasource registrationDatasource,
  }) : _registrationDatasource = registrationDatasource;

  @override
  AsyncResult<Unit, RestFailure> register(
    RegistrationDTO registration,
  ) async {
    try {
      await _registrationDatasource.register(registration);

      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }
}
