import 'package:flutter/material.dart';

import 'shared_themes_button.dart';
import 'shared_themes_colors.dart';
import 'shared_themes_typography.dart';

class SharedThemes {
  static ThemeData get theme => ThemeData(
        fontFamily: 'Pluto',
        colorSchemeSeed: SharedColors.brandMain,
        unselectedWidgetColor: SharedColors.brandMain,
        scaffoldBackgroundColor: SharedColors.background,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: SharedColors.background,
          foregroundColor: SharedColors.brandDark,
          titleTextStyle: SharedTypography.h500.copyWith(
            color: SharedColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        radioTheme: RadioThemeData(
          splashRadius: 10,
          fillColor: WidgetStateColor.resolveWith(
            (states) => SharedColors.brandMain,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: SharedColors.textPrimary,
        ),
        elevatedButtonTheme: SharedThemesButton.elevatedPrimary,
        outlinedButtonTheme: SharedThemesButton.outlinedPrimary,
      );
}
