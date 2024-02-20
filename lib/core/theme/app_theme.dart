import 'package:eshoes_clean_arch/core/constant/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kLightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: kLightSecondaryColor,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: kLightSecondaryColor),
    ),
    colorScheme: ColorScheme.light(secondary: kLightSecondaryColor)
        .copyWith(background: kLightBackgroundColor),
  );

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: kDarkPrimayColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: kDarkTextColor),
      ),
      colorScheme: ColorScheme.light(secondary: kLightSecondaryColor)
          .copyWith(background: kDarkBackgroundColor));
}
