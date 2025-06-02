import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/forgot_password_datasource.dart';
import 'data/datasources/forgot_password_datasource_imp.dart';
import 'data/repositories/forgot_password_repository_imp.dart';
import 'domain/repositories/forgot_password_repository.dart';
import 'domain/usecases/forgot_password_new_password_usecase.dart';
import 'domain/usecases/forgot_password_request_code_usecase.dart';
import 'domain/usecases/forgot_password_validate_code_usecase.dart';
import 'forgot_password_routes.dart';
import 'presentation/controllers/forgot_password_code_controller.dart';
import 'presentation/controllers/forgot_password_email_controller.dart';
import 'presentation/controllers/forgot_password_password_controller.dart';
import 'presentation/pages/forgot_password_code_page.dart';
import 'presentation/pages/forgot_password_email_page.dart';
import 'presentation/pages/forgot_password_password_page.dart';

class ForgotPasswordModule extends Module {
  @override
  void binds(Injector i) {
    // Datasources
    i.addLazySingleton<ForgotPasswordDatasource>(
        ForgotPasswordDatasourceImp.new);
    // Repositories
    i.addLazySingleton<ForgotPasswordRepository>(
        ForgotPasswordRepositoryImp.new);
    // Usecases
    i.addLazySingleton<ForgotPasswordRequestCodeUsecase>(
        ForgotPasswordRequestCodeUsecaseImp.new);
    i.addLazySingleton<ForgotPasswordValidateCodeUsecase>(
        ForgotPasswordValidateCodeUsecaseImp.new);
    i.addLazySingleton<ForgotPasswordNewPasswordUsecase>(
        ForgotPasswordNewPasswordUsecaseImp.new);
    // Controllers
    i.addLazySingleton<ForgotPasswordEmailController>(
        ForgotPasswordEmailControllerImp.new);
    i.addLazySingleton<ForgotPasswordCodeController>(
        ForgotPasswordCodeControllerImp.new);
    i.addLazySingleton<ForgotPasswordPasswordController>(
        ForgotPasswordPasswordControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      ForgotPasswordRoutes.forgotPasswordEmail,
      child: (context) => ForgotPasswordEmailPage(),
    );
    r.child(
      ForgotPasswordRoutes.forgotPasswordCode,
      child: (context) => ForgotPasswordCodePage(),
    );
    r.child(
      ForgotPasswordRoutes.forgotPasswordPassword,
      child: (context) => ForgotPasswordPasswordPage(),
    );
    super.routes(r);
  }
}
