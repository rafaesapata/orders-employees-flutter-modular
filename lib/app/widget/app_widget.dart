import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../modules/shared/domain/consts/shared_globals_keys.dart';
import '../../modules/shared/domain/extensions/shared_extensions_theme_mode.dart';
import '../../modules/shared/domain/themes/shared_themes_colors.dart';
import '../app_flavor_enum.dart';
import 'app_controller.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with ChangeNotifier {
  late AppController controller;

  @override
  void initState() {
    Modular.setNavigatorKey(SharedGlobalsKeys.navigatorKey);
    initializeDateFormatting(Platform.localeName, '');
    controller = Modular.get<AppController>();
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller.themeMode,
        builder: (_, themeMode, __) => GlobalLoaderOverlay(
          overlayWidgetBuilder: null,
          disableBackButton: true,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: SharedColors.background,
              statusBarBrightness:
                  themeMode.isDark ? Brightness.dark : Brightness.light,
              statusBarIconBrightness:
                  themeMode.isDark ? Brightness.light : Brightness.dark,
              systemNavigationBarIconBrightness:
                  themeMode.isDark ? Brightness.light : Brightness.dark,
            ),
            child: MaterialApp.router(
              key: SharedGlobalsKeys.globalKey,
              scaffoldMessengerKey: SharedGlobalsKeys.scaffoldMessengerKey,
              title: AppFlavor.title,
              themeMode: themeMode,
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              debugShowCheckedModeBanner: false,
              routeInformationParser: Modular.routeInformationParser,
              routerDelegate: Modular.routerDelegate,
            ),
          ),
        ),
      );
}
