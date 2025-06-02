import 'package:flutter_modular/flutter_modular.dart';

import '../modules/access/access_module.dart';
import '../modules/employees/employees_module.dart';
import '../modules/home/home_module.dart';
import '../modules/onboarding/onboarding_module.dart';
import '../modules/orders/orders_module.dart';
import '../modules/splash/splash_module.dart';
import 'widget/app_controller.dart';

final appTransition = TransitionType.rightToLeft;

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AppController>(AppControllerImp.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(
      Modular.initialRoute,
      transition: TransitionType.fadeIn,
      module: SplashModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: OnboardingModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: AccessModule(),
    );
    r.module(
      Modular.initialRoute,
      transition: appTransition,
      module: HomeModule(),
    );
    r.module(
      '/orders',
      transition: appTransition,
      module: OrdersModule(),
    );
    r.module(
      '/employees',
      transition: appTransition,
      module: EmployeesModule(),
    );
    super.routes(r);
  }
}

