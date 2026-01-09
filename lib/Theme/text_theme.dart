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
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800, // Semibold
          color: SAppColors.primaryBlue,
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

        // Review and Price Text Style
        displaySmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800, // Bold
          color: SAppColors.textGray,
        ),

        // For Navigation Text
        headlineSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500, // Medium
          color: SAppColors.descriptionTextGray,
        ),
  );

// Dark Theme Text Style
    static const TextTheme darkTextTheme = TextTheme(
    // Heading
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: SAppColors.white,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: SAppColors.white,
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: SAppColors.lightBlue,
    ),

    // Body
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: SAppColors.white,
    ),

    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: SAppColors.white70,
    ),

    // Labels
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: SAppColors.white,
    ),

    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: SAppColors.error,
    ),

    // Misc
    displaySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w800,
      color: SAppColors.white,
    ),

    headlineSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: SAppColors.white70,
    ),
  );

}