import 'package:fingerprint_app/configs/config.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Config theme here

  static ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: appColor),
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(
        color: blackColor,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: blackColor,
        size: 24,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: whiteColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: whiteColor,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: appColor,
      unselectedItemColor: greyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    // More config
  );

  static ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: appColor),
    scaffoldBackgroundColor: whiteColor,

    // More config
  );
}
