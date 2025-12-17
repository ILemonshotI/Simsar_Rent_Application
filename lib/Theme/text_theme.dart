import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';

class STextTheme {
  STextTheme._();
  
// Light Theme Text Styles
  static const TextTheme lightTextTheme = TextTheme(
        // Heading: Inter / Semibold / 20
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600, // Semibold
          color: SAppColors.textGray,
        ),

        // Widget Headings: Inter / Regular / 16
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.textGray,
        ),

        // Paragraph: Inter / Regular / 14
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.descriptionTextGray,
        ),
        
        // Description: Inter / Regular / 10
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.descriptionTextGray,
        ),
        
        // Field Labels: Inter / Semibold / 14
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600, // Semibold
          color: SAppColors.textGray,
        ),

        // Error Text Style
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.error,
        ),
  );

// Dark Theme Text Style
  static const TextTheme darkTextTheme = TextTheme(
        // Heading: Inter / Semibold / 20
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600, // Semibold
          color: SAppColors.textGray,
        ),

        // Widget Headings: Inter / Regular / 16
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.textGray,
        ),

        // Paragraph: Inter / Regular / 14
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.textGray,
        ),

         // Description: Inter / Regular / 10
        bodySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400, // Regular
          color: SAppColors.descriptionTextGray,
        ),
        
        // Field Labels: Inter / Semibold / 14
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600, // Semibold
          color: SAppColors.textGray,
        ),
  );
}