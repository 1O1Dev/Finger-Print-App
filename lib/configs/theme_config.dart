import 'package:fingerprint_app/configs/config.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Config theme here

  static ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: appColor),
    scaffoldBackgroundColor: whiteColor,

    // More config
  );

  static ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: appColor),
    scaffoldBackgroundColor: whiteColor,

    // More config
  );
}
