import 'package:flutter_modular/flutter_modular.dart';

import '../../shared_module.dart';
import '../../submodules/rest/rest_module.dart';

class SharedBaseModule extends Module {
  List<Module> get baseImports => [
        RestModule(),
        SharedModule(),
      ];

  List<Module> get moduleImports => const [];

  @override
  List<Module> get imports {
    var importsList = baseImports;
    importsList.addAll(moduleImports);
    return importsList;
  }
}
