import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';


class SCheckboxTheme {
  SCheckboxTheme._(); // To prevent external instantiation

  /// --- Light Checkbox Theme ---
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    // 2. Check Color: The color of the check mark when selected
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.background; 
      }
      else {
        return SAppColors.primaryBlue;
      }
    }),

    // 3. Fill Color: The color that fills the box (the border is derived from this)
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.primaryBlue; 
      }
      else {
        return SAppColors.transparent; 
      } 
    }),

    // 4. Border Side: Defines the border around the unselected checkbox
    side: const BorderSide(
      width: 2,
      color: SAppColors.primaryBlue, // Color of the border when unchecked
    ),
  ); 

  /// --- Dark Checkbox Theme ---
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.primaryBlue; 
      }
      else  {
        return SAppColors.transparent; 
      }
    }),

    // 3. Fill Color: The color that fills the box (the border is derived from this)
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SAppColors.primaryBlue; 
      }
      else  {
        return SAppColors.transparent; 
      } 
    }),

    // 4. Border Side: Defines the border around the unselected checkbox
    side: const BorderSide(
      width: 2,
      color: SAppColors.primaryBlue, // Color of the border when unchecked
    ),
  ); // CheckboxThemeData
}