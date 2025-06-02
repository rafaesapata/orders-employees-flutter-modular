import 'package:result_dart/result_dart.dart';

import '../../../../../shared/data/models/user_model.dart';
import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/login_dto.dart';
import '../repositories/login_repository.dart';

abstract class LoginWithAPIUseCase
    extends SharedBaseUsecaseInputOutput<LoginDTO, UserModel> {}

class LoginWithAPIUseCaseImp implements LoginWithAPIUseCase {
  final LoginRepository _loginRepository;

  LoginWithAPIUseCaseImp({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  @override
  AsyncResult<UserModel, RestFailure> call(LoginDTO login) async =>
      await _loginRepository.loginWithAPI(login: login);
}
