import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simsar/Theme/slider_theme.dart';
import 'package:simsar/Theme/text_theme.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_input_field.dart';
import 'package:simsar/Theme/appbar_theme.dart';
import 'package:simsar/Theme/bottom_sheet_theme.dart';
import 'package:simsar/Theme/elevated_button_theme.dart'; 
import 'package:simsar/Theme/check_box_theme.dart';
import 'package:simsar/Theme/segmented_button_theme.dart';
import 'package:simsar/Theme/outlined_button_theme.dart';

import 'calender_date_picker_theme.dart';
class   SAppTheme {
  SAppTheme._();
  static final ThemeData lightTheme = ThemeData(
  useMaterial3:true,
  fontFamily: GoogleFonts.inter().fontFamily,
  brightness: Brightness.light,
  scaffoldBackgroundColor: SAppColors.background,
  textTheme: STextTheme.lightTextTheme,
  inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  appBarTheme: SAppBarTheme.lightAppBarTheme,
  bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
  elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonThemeData,
  segmentedButtonTheme: SSegmentedButtonTheme.lightSegmentedButtonThemeData,
  checkboxTheme: SCheckboxTheme.lightCheckboxTheme, 
  sliderTheme: SSliderTheme.lightThemeData,
  outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonThemeData,
  datePickerTheme: SDatePickerTheme.lightDatePickerTheme,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
  color: SAppColors.secondaryDarkBlue,
),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: SAppColors.primaryBlue, // The vertical "|" bar
      selectionColor: SAppColors.primaryBlue.withValues(alpha: 0.3), // Highlight color
      selectionHandleColor: SAppColors.primaryBlue, // The bubbles at the bottom of the selection
    ),
  ); 

  static final ThemeData darkTheme = ThemeData(
  useMaterial3:true,
  fontFamily: GoogleFonts.inter().fontFamily,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: SAppColors.darkBackground,
  textTheme: STextTheme.darkTextTheme,
  inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  appBarTheme: SAppBarTheme.darkAppBarTheme,
  bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
  elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonThemeData,
  segmentedButtonTheme: SSegmentedButtonTheme.darkSegmentedButtonThemeData,
  checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
  sliderTheme: SSliderTheme.darkThemeData,
  outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonThemeData,
  datePickerTheme: SDatePickerTheme.darkDatePickerTheme,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
  color: SAppColors.secondaryDarkBlue,
),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: SAppColors.primaryBlue,
      selectionColor: SAppColors.primaryBlue.withValues(alpha: 0.5),
      selectionHandleColor: SAppColors.primaryBlue,
    ),
  );
  }
