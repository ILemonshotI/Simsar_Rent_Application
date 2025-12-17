import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';

class SBottomSheetTheme {
  SBottomSheetTheme._();

static const topRoundedShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30), // Adjust this radius as needed
      topRight: Radius.circular(30), // Adjust this radius as needed
      bottomLeft: Radius.zero, // Keep the bottom left corner sharp
      bottomRight: Radius.zero, // Keep the bottom right corner sharp
    ),
  );

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: SAppColors.background,
    modalBackgroundColor: SAppColors.background,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: topRoundedShape,
  ); // BottomSheetThemeData

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: SAppColors.darkBackground,
    modalBackgroundColor: SAppColors.darkBackground,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: topRoundedShape,
  ); // BottomSheetThemeData
}