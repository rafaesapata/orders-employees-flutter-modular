import 'package:flutter_modular/flutter_modular.dart';

import '../../shared_module.dart';
import 'data/provider/rest_provider_imp.dart';

class RestModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void exportedBinds(Injector i) {
    i.addSingleton<RestProvider>(RestProviderImp.new);

    super.exportedBinds(i);
  }
}
