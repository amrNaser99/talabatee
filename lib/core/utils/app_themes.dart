import 'package:talabatee/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talabatee/core/utils/app_fonts.dart';
import 'package:talabatee/core/utils/app_spaces.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      titleSpacing: 0.0,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo',
        ),
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo',
        ),
      ).titleLarge,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // foregroundColor: AppColors.teal,
        textStyle: TextStyle(
          decoration: TextDecoration.none,
          color: AppColors.textColor,
          // fontSize: FontSize.s15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s20,
          ),
        ),
        minimumSize: Size(
          double.infinity,
          AppHeight.h45,
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'cairo',
      ),
      displayMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'cairo',
      ),
      displaySmall: TextStyle(
        color: AppColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'cairo',
      ),
      headlineMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 18,
        fontFamily: 'cairo',
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.textColor,
        fontSize: 16,
        fontFamily: 'cairo',
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'cairo',
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textColor,
        fontSize: 16,
        fontFamily: 'cairo',
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 14,
        fontFamily: 'cairo',
        fontWeight: FontWeight.normal,
      ),
    ),
    fontFamily: FontFamily.fontFamily,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.generateMaterialColor(
        AppColors.primaryColor,
      ),

    ).copyWith(
      background: AppColors.scaffoldBackgroundColor,
    ),
  );
}
