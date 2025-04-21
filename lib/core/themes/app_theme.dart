import 'package:WardrobePlus/core/themes/app_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallet.lightBackgroundColor,
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: AppPallet.lightTextColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppPallet.lightHintTextColor,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: AppPallet.lightBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallet.lightHintTextColor, width: 1),
        borderRadius: BorderRadius.circular(22),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallet.lightHintTextColor, width: 1),
        borderRadius: BorderRadius.circular(22),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallet.lightTextColor, width: 1),
        borderRadius: BorderRadius.circular(22),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        backgroundColor: AppPallet.lightButtonColor,
        foregroundColor: AppPallet.lightBackgroundColor,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: Size(double.infinity, 50),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        backgroundColor: AppPallet.lightBackgroundColor,
        foregroundColor: AppPallet.lightButtonColor,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: Size(double.infinity, 50),
      ),
    ),
  );
}
