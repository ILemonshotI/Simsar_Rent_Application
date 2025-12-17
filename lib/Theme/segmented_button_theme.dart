import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';
class SSegmentedButtonTheme {
  SSegmentedButtonTheme._();

  static final SegmentedButtonThemeData lightSegmentedButtonThemeData = SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      // Border and Shape
      side: const BorderSide(color: SAppColors.primaryBlue, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      
      // Selected State Colors
      selectedBackgroundColor: SAppColors.primaryBlue,
      selectedForegroundColor: SAppColors.background,
      
      // Unselected State Colors
      backgroundColor: SAppColors.background,
      foregroundColor: SAppColors.textGray, // Assuming this exists in your AppColors
      
      // Text Style
      textStyle: STextTheme.lightTextTheme.labelLarge,
    ),
  );

  static final SegmentedButtonThemeData darkSegmentedButtonThemeData = SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      // Border and Shape
      side: const BorderSide(color: SAppColors.primaryBlue, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      
      // Selected State Colors
      selectedBackgroundColor: SAppColors.primaryBlue,
      selectedForegroundColor: SAppColors.darkBackground,
      
      // Unselected State Colors
      backgroundColor: SAppColors.darkBackground,
      foregroundColor: SAppColors.textGray,
      
      // Text Style
      textStyle: STextTheme.darkTextTheme.labelLarge,
      ),
    );
}