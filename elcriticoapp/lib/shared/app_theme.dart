import 'package:flutter/material.dart';
import 'package:elcriticoapp/extensions/string_api.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const TextTheme textTheme = TextTheme(
  bodyLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
  bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
  bodySmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
  displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
  displayMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
  displaySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
  labelLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
  labelMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
  labelSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
  headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  headlineSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
);

final ColorScheme lightPalette = ColorScheme(
  brightness: Brightness.light,
  primary: "#007D50".toColor(),
  onPrimary: Colors.white,
  secondary: "#FF0000".toColor(),
  onSecondary: Colors.black,
  tertiary: "#2C2934".toColor(),
  onTertiary: Colors.white,
  error: "#DE3445".toColor(),
  onError: Colors.black,
  background: "#F9F9F9".toColor(),
  onBackground: Colors.black,
  surface: "#FAF8FF".toColor(),
  onSurface: Colors.black,
);

final ColorScheme darkPalette = ColorScheme(
  brightness: Brightness.dark,
  primary: "#007D50".toColor(),
  onPrimary: Colors.white,
  secondary: "#FF0000".toColor(),
  onSecondary: Colors.white,
  tertiary: "#2C2934".toColor(),
  onTertiary: Colors.white,
  error: "#DE3445".toColor(),
  onError: Colors.white,
  background: "#0D1720".toColor(),
  onBackground: "F4F4F4".toColor(),
  surface: "#FAF8FF".toColor(),
  onSurface: Colors.white,
);

final elcriticoLightTheme = ThemeData(
  fontFamily: GoogleFonts.lora().fontFamily,
  useMaterial3: true,
  textTheme: textTheme.apply(
    bodyColor: lightPalette.onBackground,
  ),
  colorScheme: lightPalette,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: lightPalette.background,
    titleSpacing: 12,
    titleTextStyle: TextStyle(color: lightPalette.onBackground),
    shadowColor: Colors.transparent,
    surfaceTintColor: lightPalette.tertiary,
  ),
  splashFactory: InkRipple.splashFactory,
  iconTheme: IconThemeData(
    color: lightPalette.primary,
    size: 20,
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 128,
    backgroundColor: lightPalette.tertiary,
    indicatorColor: lightPalette.primary,
    iconTheme: MaterialStatePropertyAll(
      IconThemeData(
        color: lightPalette.onTertiary,
      ),
    ),
    elevation: 0,
    labelTextStyle: MaterialStateProperty.all(
      textTheme.labelSmall!.copyWith(
        color: lightPalette.onTertiary,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: lightPalette.onBackground,
      contentPadding: const EdgeInsets.all(6.5),
      filled: false,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: lightPalette.primary, width: 1)),
      focusColor: lightPalette.primary),
);

final elcriticoDarkTheme = ThemeData(
    fontFamily: GoogleFonts.lora().fontFamily,
    useMaterial3: true,
    textTheme: textTheme.apply(
      displayColor: darkPalette.onBackground,
      bodyColor: darkPalette.onBackground,
    ),
    colorScheme: darkPalette,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: darkPalette.background,
      titleSpacing: 12,
      titleTextStyle: TextStyle(color: darkPalette.onBackground),
      shadowColor: Colors.transparent,
      surfaceTintColor: darkPalette.tertiary,
      elevation: 0,
    ),
    splashFactory: InkRipple.splashFactory,
    iconTheme: IconThemeData(
      color: darkPalette.primary,
      size: 20,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkPalette.tertiary,
      indicatorColor: darkPalette.primary,
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(
          color: darkPalette.onTertiary,
        ),
      ),
      elevation: 0,
      labelTextStyle: MaterialStateProperty.all(
        textTheme.labelSmall!.copyWith(
          color: darkPalette.onTertiary,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: darkPalette.onBackground,
        contentPadding: const EdgeInsets.all(6.5),
        filled: false,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: darkPalette.primary, width: 1),
        ),
        focusColor: darkPalette.primary),
    elevatedButtonTheme: ElevatedButtonThemeData());
