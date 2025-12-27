import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';

class SOutlinedButtonTheme {
  SOutlinedButtonTheme._();

  static final OutlinedButtonThemeData lightOutlinedButtonThemeData = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SAppColors.primaryBlue, // Text and icon color
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: SAppColors.primaryBlue, width: 1.5), // The outline
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static final OutlinedButtonThemeData darkOutlinedButtonThemeData = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SAppColors.primaryBlue,
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: SAppColors.primaryBlue, width: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}