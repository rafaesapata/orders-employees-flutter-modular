import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_config.dart';
import 'app_module.dart';
import 'widget/app_widget.dart';

Future<void> buildApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ModularApp(
      module: AppModule(),
      debugMode: AppConfig.logEnabled,
      child: const AppWidget(),
    ),
  );
}
