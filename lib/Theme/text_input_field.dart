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
    // Input properties
    errorMaxLines: 1,
    prefixIconColor: SAppColors.textGray,
    suffixIconColor: SAppColors.textGray,

    // constraints: const BoxConstraints.expand(height: 48), // Assuming a custom extension on BoxConstraints
    labelStyle: STextTheme.darkTextTheme.labelLarge,
    hintStyle: STextTheme.darkTextTheme.bodyMedium,
    errorStyle: STextTheme.darkTextTheme.labelSmall,
    floatingLabelStyle: STextTheme.darkTextTheme.labelLarge,
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
}