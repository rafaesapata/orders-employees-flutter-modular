import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_module.dart';
import '../shared/domain/bases/shared_base_module.dart';
import '../shared/submodules/firebase/firebase_module.dart';
import 'access_routes.dart';
import 'presentation/controllers/access_controller.dart';
import 'presentation/pages/access_page.dart';
import 'submodules/confirm_account/confirm_account_module.dart';
import 'submodules/forgot_password/forgot_password_module.dart';
import 'submodules/login/login_module.dart';
import 'submodules/registration/registration_module.dart';

class AccessModule extends SharedBaseModule {
  @override
  List<Module> get imports => [
        FirebaseModule(),
      ];

  @override
  void binds(Injector i) {
    // Controllers
    i.add<AccessController>(AccessControllerImp.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: LoginModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: RegistrationModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: ForgotPasswordModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: ConfirmAccountModule(),
    );
    r.child(
      AccessRoutes.access,
      child: (_) => const AccessPage(),
    );
    super.routes(r);
  }
}
