import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/domain/bases/shared_base_module.dart';
import 'data/datasources/registration_datasource.dart';
import 'data/datasources/remote/registration_datasource_imp.dart';
import 'data/repositories/registration_repository_imp.dart';
import 'domain/repositories/registration_repository.dart';
import 'domain/usecases/make_registration_use_case.dart';
import 'presentation/controllers/registration_contact_controller.dart';
import 'presentation/controllers/registration_controller.dart';
import 'presentation/controllers/registration_password_controller.dart';
import 'presentation/controllers/registration_user_data_controller.dart';
import 'presentation/pages/registration_page.dart';
import 'registration_routes.dart';

class RegistrationModule extends SharedBaseModule {
  @override
  void binds(Injector i) {
    // Datasources
    i.addLazySingleton<RegistrationDatasource>(RegistrationDatasourceImp.new);
    // Repositories
    i.addLazySingleton<RegistrationRepository>(RegistrationRepositoryImp.new);
    // Usecases
    i.addLazySingleton<MakeRegistrationUseCase>(MakeRegistrationUseCaseImp.new);
    // Controllers
    i.add<RegistrationController>(RegistrationControllerImp.new);
    i.add<RegistrationUserDataController>(
        RegistrationUserDataControllerImp.new);
    i.add<RegistrationContactController>(RegistrationContactControllerImp.new);
    i.add<RegistrationPasswordController>(
        RegistrationPasswordControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      RegistrationRoutes.registration,
      child: (_) => RegistrationPage(),
    );
    super.routes(r);
  }
}
