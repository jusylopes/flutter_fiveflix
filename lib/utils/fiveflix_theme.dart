import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

abstract class FiveflixTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        fontFamily: FiveflixStrings.appFontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: FiveflixColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: FiveflixColors.seedColor,
          primary: FiveflixColors.primaryColor,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: 12.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all(Colors.white),
            iconSize: WidgetStateProperty.all(30.0),
          ),
        ),
        dividerColor: FiveflixColors.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          backgroundColor: FiveflixColors.appBarColor,
          unselectedItemColor: FiveflixColors.unselectedItemColor,
          selectedIconTheme: IconThemeData(size: 30),
        ),
      );
}
