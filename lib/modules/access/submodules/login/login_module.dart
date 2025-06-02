import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app/app_module.dart';
import '../../../shared/domain/bases/shared_base_module.dart';
import '../../../shared/submodules/amplify/amplify_module.dart';
import 'data/datasources/login_datasource.dart';
import 'data/datasources/remote/login_datasource_imp.dart';
import 'data/repositories/login_repository_imp.dart';
import 'domain/repositories/login_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'login_routes.dart';
import 'presentation/controllers/login_controller.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/unauthorized_page.dart';

class LoginModule extends SharedBaseModule {
  @override
  List<Module> get moduleImports => [
        AmplifyModule(),
      ];

  @override
  void binds(Injector i) {
    // Datasources
    i.addLazySingleton<LoginDatasource>(LoginDatasourceImp.new);
    // Repositories
    i.addLazySingleton<LoginRepository>(LoginRepositoryImp.new);
    // Usecases
    i.addLazySingleton<LoginWithAPIUseCase>(LoginWithAPIUseCaseImp.new);
    // Controllers
    i.add<LoginController>(LoginControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      LoginRoutes.login,
      transition: appTransition,
      child: (_) => const LoginPage(),
    );
    r.child(
      LoginRoutes.unauthorized,
      transition: appTransition,
      child: (_) => const UnauthorizedPage(),
    );
    super.routes(r);
  }
}
