import 'package:cep_app/shared/ui/cep_app_colors.dart';
import 'package:flutter/material.dart';

sealed class CepAppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: CepAppColors.primaryColor,
      onPrimary: CepAppColors.primaryColor,
      secondary: CepAppColors.secondaryColor,
      onSecondary: CepAppColors.secondaryColor,
      error: CepAppColors.errorColor,
      onError: CepAppColors.errorColor,
      background: CepAppColors.lightBgColor,
      onBackground: CepAppColors.lightBgColor,
      surface: CepAppColors.lightBgColor,
      onSurface: CepAppColors.lightBgColor,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.black.withOpacity(.3),
      labelColor: CepAppColors.secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: CepAppColors.lightBgColor,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: CepAppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CepAppColors.primaryColor,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colors.white),
      thumbColor: const MaterialStatePropertyAll(
        CepAppColors.primaryColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CepAppColors.primaryColor,
      titleTextStyle: TextStyle(
        color: CepAppColors.secondaryColor,
        fontSize: 16,
      ),
    ),
    scaffoldBackgroundColor: CepAppColors.lightBgColor,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: CepAppColors.blackColor,
        fontSize: 14,
      ),
      titleMedium: TextStyle(
        color: CepAppColors.blackColor,
        fontSize: 20,
      ),
    ),
  );

  static final ThemeData dark = light.copyWith(
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.grey,
      labelColor: CepAppColors.primaryColor,
    ),
    appBarTheme: light.appBarTheme.copyWith(
      backgroundColor: Colors.black87,
    ),
    scaffoldBackgroundColor: CepAppColors.darkBgColor,
    brightness: Brightness.dark,
    colorScheme: light.colorScheme.copyWith(
      brightness: Brightness.dark,
      background: CepAppColors.darkBgColor,
      onBackground: CepAppColors.darkBgColor,
      surface: CepAppColors.darkBgColor,
      onSurface: CepAppColors.darkBgColor,
    ),
    textTheme: light.textTheme.copyWith(
      bodyMedium: light.textTheme.bodyMedium!.copyWith(
        color: CepAppColors.whiteColor,
      ),
      titleMedium: light.textTheme.titleMedium!.copyWith(
        color: CepAppColors.whiteColor,
      ),
    ),
    inputDecorationTheme: light.inputDecorationTheme.copyWith(
      fillColor: CepAppColors.blackColor,
    ),
  );
}
