import 'package:flutter/material.dart';
import 'package:simsar/Theme/app_colors.dart';
import 'package:simsar/Theme/text_theme.dart';

class SAppBarTheme {
  SAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: SAppColors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: SAppColors.textGray, size: 24),
    actionsIconTheme: IconThemeData(color: SAppColors.textGray, size: 24),
    titleTextStyle: STextTheme.lightTextTheme.titleLarge,
  ); // AppBarTheme

  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: SAppColors.transparent,
    surfaceTintColor: SAppColors.transparent,
    iconTheme: IconThemeData(color: SAppColors.textGray, size: 24),
    actionsIconTheme: IconThemeData(color: SAppColors.textGray, size: 24),
    titleTextStyle: STextTheme.lightTextTheme.titleLarge,
  ); // AppBarTheme
}