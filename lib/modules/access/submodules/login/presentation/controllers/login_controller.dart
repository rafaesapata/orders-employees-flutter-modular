import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../home/home_routes.dart';
import '../../../../../shared/domain/bases/shared_base_controller.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_string.dart';
import '../../../../../shared/domain/usecases/shared_fetch_remote_user_usecase.dart';
import '../../../../../shared/presentation/components/shared_snack_bar.dart';
import '../../../../../shared/submodules/amplify/domain/dtos/amplify_sign_in_dto.dart';
import '../../../../../shared/submodules/amplify/domain/usecases/amplify_sign_in_cognito_usecase.dart';
import '../../../../../shared/submodules/amplify/domain/usecases/amplify_sign_out_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure_user_not_allowed.dart';
import '../../../confirm_account/confirm_account_routes.dart';

enum LoginPageState { loading, ready, error, success, empty }

abstract class LoginController extends SharedBaseController {
  TextEditingController get emailController;
  TextEditingController get passwordController;
  void enableButton();
  Future<void> doLogin({Function() onRetry});
}

class LoginControllerImp extends LoginController {
  final AmplifySignInCognitoUsecase _amplifySignInCognitoUsecase;
  final AmplifySignOutUsecase _amplifySignOutUsecase;
  final SharedFetchRemoteUserUseCase _fetchUserDataUseCase;

  @override
  final emailController = TextEditingController();

  @override
  final passwordController = TextEditingController();

  LoginControllerImp({
    required AmplifySignInCognitoUsecase amplifySignInCognitoUsecase,
    required SharedFetchRemoteUserUseCase fetchUserDataUseCase,
    required AmplifySignOutUsecase amplifySignOutUsecase,
  })  : _amplifySignInCognitoUsecase = amplifySignInCognitoUsecase,
        _amplifySignOutUsecase = amplifySignOutUsecase,
        _fetchUserDataUseCase = fetchUserDataUseCase;

  @override
  void enableButton() => isValid.value =
      emailController.text.isEmailValid && passwordController.text.isNotEmpty;

  @override
  Future<void> doLogin({Function()? onRetry}) async {
    pageState.value = SharedEnumPageState.loading;

    final result = await _amplifySignInCognitoUsecase(
      AmplifySignInDto(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
    await result.fold(
      (entity) async {
        if (entity.isSignedIn && entity.signInStep == AuthSignInStep.done) {
          await _fetchUserDataAfterLogin();
        } else if (entity.signInStep == AuthSignInStep.confirmSignUp) {
          await _confirmAccount();
        } else {
          pageState.value = SharedEnumPageState.error;
          await _signOut();
        }
      },
      (error) async {
        if (error is UserNotConfirmedException) {
          await _confirmAccount();
        } else if (error is UserCancelledException) {
          pageState.value = SharedEnumPageState.error;
        }
      },
    );
  }

  Future<void> _fetchUserDataAfterLogin() async {
    final result = await _fetchUserDataUseCase();
    result.fold(
      (success) {
        // Save user in storage
        Modular.to.pushReplacementNamed(HomeRoutes.home, forRoot: true);
      },
      (error) {
        if (error is RestFailureUserNotAllowed) {
          showSnackBar(message: error.message!);
        }
        _signOut();
      },
    );
  }

  Future<void> _signOut() async {
    final result = await _amplifySignOutUsecase();
    result.fold((success) => null, (error) => null);
  }

  Future<void> _confirmAccount() async {
    final result =
        await Modular.to.pushNamed<bool>(ConfirmAccountRoutes.confirmAccount);
    if (result == true) {
      doLogin();
    }
  }
}
