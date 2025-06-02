import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/shared/domain/enums/shared_enum_prefs_keys.dart';
import '../../modules/shared/domain/themes/shared_themes_colors.dart';

abstract class AppController extends ChangeNotifier {
  ValueNotifier<ThemeMode> get themeMode;
  Future<void> initialize();
  void changeThemeMode(ThemeMode mode);
}

class AppControllerImp extends AppController {
  late final SharedPreferences _sharedPreferences;
  final _themeModeKey = SharedEnumPrefsKeys.themeModeKey.key;

  @override
  final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);

  @override
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final cached = _sharedPreferences.getString(_themeModeKey);
    final mode = ThemeMode.values
            .firstWhereOrNull((element) => element.name == cached) ??
        themeMode.value;
    setAppColors(mode);
    themeMode.value = mode;
  }

  @override
  void changeThemeMode(ThemeMode mode) {
    _sharedPreferences.setString(_themeModeKey, mode.name);
    setAppColors(mode);
    themeMode.value = mode;
  }
}
