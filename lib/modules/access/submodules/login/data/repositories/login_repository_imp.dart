import 'package:result_dart/result_dart.dart';

import '../../../../../shared/data/models/user_model.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../../domain/dtos/login_dto.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';

class LoginRepositoryImp implements LoginRepository {
  LoginDatasource datasource;

  LoginRepositoryImp({required this.datasource});

  @override
  AsyncResult<UserModel, RestFailure> loginWithAPI(
      {required LoginDTO login}) async {
    try {
      final result = await datasource.loginWithAPI(login: login);
      return result.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e, s) {
      return RestFailure.fromError(e: e, stackTrace: s).toFailure();
    }
  }
}
