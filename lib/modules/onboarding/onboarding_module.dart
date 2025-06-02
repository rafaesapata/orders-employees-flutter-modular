import 'package:flutter_modular/flutter_modular.dart';

import '../shared/domain/bases/shared_base_module.dart';
import 'onboarding_routes.dart';
import 'presentation/controllers/onboarding_controller.dart';
import 'presentation/pages/onboarding_page.dart';

class OnboardingModule extends SharedBaseModule {
  @override
  void binds(Injector i) {
    i.addLazySingleton<OnboardingController>(OnboardingControllerImp.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      OnboardingRoutes.onboarding,
      child: (_) => const OnboardingPage(),
    );
    super.routes(r);
  }
}
