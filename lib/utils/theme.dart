import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

abstract class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        fontFamily: AppStrings.appFontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          primary: AppColors.primaryColor,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24.0,
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
            fontSize: 10.0,
            color: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(Colors.white),
            iconSize: MaterialStateProperty.all(30.0),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          backgroundColor: AppColors.appBarColor,
          unselectedItemColor: AppColors.unselectedItemColor,
          selectedIconTheme: IconThemeData(size: 30),
        ),
      );
}
