import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app/app_module.dart';
import '../../../shared/domain/bases/shared_base_module.dart';
import 'confirm_account_routes.dart';
import 'data/datasources/confirm_account_datasource.dart';
import 'data/datasources/confirm_account_datasource_imp.dart';
import 'data/repositories/confirm_account_repository_imp.dart';
import 'domain/repositories/confirm_account_repository.dart';
import 'domain/usecases/confirm_account_confirm_usecase.dart';
import 'domain/usecases/confirm_account_resend_usecase.dart';
import 'presentation/controllers/confirm_account_controller.dart';
import 'presentation/pages/confirm_account_page.dart';

class ConfirmAccountModule extends SharedBaseModule {
  @override
  void binds(Injector i) {
    // Datasources
    i.addLazySingleton<ConfirmAccountDatasource>(
        ConfirmAccountDatasourceImp.new);
    // Repositories
    i.addLazySingleton<ConfirmAccountRepository>(
        ConfirmAccountRepositoryImp.new);
    // Usecases
    i.add<ConfirmAccountConfirmUsecase>(ConfirmAccountConfirmUsecaseImp.new);
    i.add<ConfirmAccountResendUsecase>(ConfirmAccountResendUsecaseImp.new);
    // Controllers
    i.add<ConfirmAccountController>(ConfirmAccountControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      ConfirmAccountRoutes.confirmAccount,
      transition: appTransition,
      child: (_) => const ConfirmAccountPage(),
    );
    super.routes(r);
  }
}
