import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../extensions/shared_extensions_theme_mode.dart';
import 'shared_themes_colors_dark.dart';
import 'shared_themes_colors_light.dart';

// ignore: non_constant_identifier_names
SharedThemesColors SharedColors = SharedThemesColorsLight();
void setAppColors(ThemeMode themeMode) {
  var mode = themeMode;
  if (themeMode == ThemeMode.system) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    mode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }
  SharedColors =
      mode.isDark ? SharedThemesColorsDark() : SharedThemesColorsLight();
}

abstract class SharedThemesColors {
  Color get background;
  Color get white => Color(0xFFFFFFFF);
  Color get black => Color(0xFF000000);

  Color get buttonPrimaryIcon;
  Color get buttonPrimaryText;
  Color get buttonPrimaryTextDisabled;
  Color get buttonPrimaryBorder;
  Color get buttonPrimaryBackground;
  Color get buttonPrimaryBackgroundDisabled;

  Color get buttonSecondaryIcon;
  Color get buttonSecondaryText;
  Color get buttonSecondaryTextDisabled;
  Color get buttonSecondaryBorder;
  Color get buttonSecondaryBackground;
  Color get buttonSecondaryBackgroundDisabled;

  Color get iconPrimary;
  Color get iconPrimaryInverted;
  Color get iconSecondary;

  Color get textPrimary;
  Color get textPrimaryInverted;
  Color get textSecondary;

  Color get textFieldText;
  Color get textFieldLabel;
  Color get textFieldHint;
  Color get textFieldBackground;
  Color get textFieldBoder;
  Color get textFieldBoderFocus;
  Color get textFieldBoderDisabled;

  Color get brandMain => Color(0xFF008CFF);
  Color get brandLight => Color(0xFFEBFAFF);
  Color get brandDark => Color(0xFF003993);

  Color get error => Color(0xFFEB1414);
  Color get errorLight => Color(0xFFFECACA);
  Color get errorDark => Color(0xFFB91C1C);

  Color get success => Color(0xFF1AB362);
  Color get successLight => Color(0xFFBBF7D0);
  Color get successDark => Color(0xFF12965D);

  Color get warning => Color(0xFFEAB308);
  Color get warningLight => Color(0xFFFEF08A);
  Color get warningDark => Color(0xFF9B6A03);

  Color get info => Color(0xFF3B82F6);
  Color get infoLight => Color(0xFFBFDBFE);
  Color get infoDark => Color(0xFF1D4ED8);
}
