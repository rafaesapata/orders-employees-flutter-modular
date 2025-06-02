import 'package:flutter_modular/flutter_modular.dart';

import '../shared/domain/bases/shared_base_module.dart';
import 'home_routes.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends SharedBaseModule {
  @override
  void binds(Injector i) {
    // Controllers
    i.addLazySingleton<IHomeController>(HomeController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      HomeRoutes.home,
      child: ((_) => const HomePage()),
    );
    super.routes(r);
  }
}
