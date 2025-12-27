import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
class SSliderTheme {
  static SliderThemeData lightThemeData = SliderThemeData(
    activeTrackColor: SAppColors.secondaryDarkBlue,
    inactiveTrackColor: SAppColors.descriptionTextGray,
    thumbColor: SAppColors.secondaryDarkBlue,
    overlayColor: SAppColors.secondaryDarkBlue.withValues(alpha: 0.3),
    trackHeight: 4.0,
    
    // Standard Slider Shape
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
    
    // --- MANDATORY FOR RANGE SLIDER ---
    rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10.0),
    rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
    // ----------------------------------

    showValueIndicator: ShowValueIndicator.always, // Ensures labels show up
    valueIndicatorColor: SAppColors.secondaryDarkBlue,
    valueIndicatorTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );

  static SliderThemeData darkThemeData = SliderThemeData(
    activeTrackColor: SAppColors.secondaryDarkBlue,
    inactiveTrackColor: SAppColors.descriptionTextGray,
    thumbColor: SAppColors.secondaryDarkBlue,
    overlayColor: SAppColors.secondaryDarkBlue.withValues(alpha: 0.3),
    trackHeight: 4.0,
    
    // Standard Slider Shape
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
    
    // --- MANDATORY FOR RANGE SLIDER ---
    rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10.0),
    rangeValueIndicatorShape: const PaddleRangeSliderValueIndicatorShape(),
    // ----------------------------------

    showValueIndicator: ShowValueIndicator.always, // Ensures labels show up
    valueIndicatorColor: SAppColors.secondaryDarkBlue,
    valueIndicatorTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );

}