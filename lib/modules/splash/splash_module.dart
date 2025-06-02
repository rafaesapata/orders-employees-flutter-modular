import 'package:flutter_modular/flutter_modular.dart';

import '../shared/domain/bases/shared_base_module.dart';
import '../shared/submodules/amplify/amplify_module.dart';
import '../shared/submodules/firebase/firebase_module.dart';
import 'presentation/controllers/splash_controller.dart';
import 'presentation/pages/splash_page.dart';

class SplashModule extends SharedBaseModule {
  @override
  List<Module> get moduleImports => [
        FirebaseModule(),
        AmplifyModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<SplashController>(SplashControllerImp.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: ((_) => const SplashPage()),
    );
    super.routes(r);
  }
}
