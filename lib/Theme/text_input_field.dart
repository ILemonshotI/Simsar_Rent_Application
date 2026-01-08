import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'text_theme.dart';

class STextFormFieldTheme {
  STextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    // Input properties
    errorMaxLines: 1,
    prefixIconColor: SAppColors.textGray,
    suffixIconColor: SAppColors.textGray,

    // constraints: const BoxConstraints.expand(height: 14.inputFieldHeight), // Assuming a custom extension on BoxConstraints
    labelStyle: STextTheme.lightTextTheme.labelLarge,
    hintStyle: STextTheme.lightTextTheme.bodyMedium,
    errorStyle: STextTheme.lightTextTheme.labelSmall,
    floatingLabelStyle: STextTheme.lightTextTheme.labelLarge,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: SAppColors.outlineGray),
    ),

    // Enabled Border
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: SAppColors.outlineGray),
    ),

    // Focused Border
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: SAppColors.secondaryDarkBlue),
    ),

    // Error Border
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: SAppColors.error),
    ),

    // Focused Error Border
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: SAppColors.error),
    ),
  );
  
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 1,

    // 🔹 Icons
    prefixIconColor: SAppColors.white.withValues(alpha: 0.7),
    suffixIconColor: SAppColors.white.withValues(alpha: 0.7),

    // 🔹 Text styles
    labelStyle: STextTheme.darkTextTheme.labelLarge,
    hintStyle: STextTheme.darkTextTheme.bodyMedium,
    errorStyle: STextTheme.darkTextTheme.labelSmall,
    floatingLabelStyle: STextTheme.darkTextTheme.labelLarge,

    // 🔹 Field layout
    contentPadding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),

    // 🔹 Filled background
    filled: true,
    fillColor:
        SAppColors.secondaryDarkBlue.withValues(alpha: 0.35),

    // 🔹 Default border
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1,
        color: SAppColors.outlineGray.withValues(alpha: 0.4),
      ),
    ),

    // 🔹 Enabled
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1,
        color: SAppColors.outlineGray.withValues(alpha: 0.4),
      ),
    ),

    // 🔹 Focused
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1.5,
        color: SAppColors.lightBlue,
      ),
    ),

    // 🔹 Error
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1,
        color: SAppColors.error,
      ),
    ),

    // 🔹 Focused error
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1.5,
        color: SAppColors.error,
      ),
    ),
  );

}