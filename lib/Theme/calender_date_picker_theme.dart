import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';

class SDatePickerTheme {
  SDatePickerTheme._();

  static final DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
    // This changes the circle around the selected day
    todayBackgroundColor: WidgetStateProperty.all(SAppColors.primaryBlue.withOpacity(0.2)),
    todayForegroundColor: WidgetStateProperty.all(SAppColors.primaryBlue),
    
    // The actual selection circle color
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.primaryBlue;
      }
      return null;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.white;
      }
      return SAppColors.secondaryDarkBlue; // Regular day text color
    }),

    // Header styling
    headerBackgroundColor: SAppColors.primaryBlue,
    headerForegroundColor: SAppColors.white,
    
    // Year/Month picker styling
    yearStyle: const TextStyle(color: SAppColors.secondaryDarkBlue),
  );

  static final DatePickerThemeData darkDatePickerTheme = DatePickerThemeData(
    todayBackgroundColor: WidgetStateProperty.all(SAppColors.primaryBlue.withOpacity(0.3)),
    todayForegroundColor: WidgetStateProperty.all(SAppColors.primaryBlue),
    
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.primaryBlue;
      }
      return null;
    }),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.white;
      }
      return SAppColors.white; 
    }),
  );
}