import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';

class SElevatedButtonTheme {
  SElevatedButtonTheme._();

  static final ElevatedButtonThemeData lightElevatedButtonThemeData = ElevatedButtonThemeData(
   style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: SAppColors.primaryBlue,
    foregroundColor: SAppColors.white,
    disabledBackgroundColor: SAppColors.outlineGray,
    disabledForegroundColor: SAppColors.outlineGray,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
   ),    
  );

  static final ElevatedButtonThemeData darkElevatedButtonThemeData = ElevatedButtonThemeData(
   style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: SAppColors.primaryBlue,
    foregroundColor: SAppColors.white,
    disabledBackgroundColor: SAppColors.outlineGray,
    disabledForegroundColor: SAppColors.outlineGray,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
   ),    
  );
}