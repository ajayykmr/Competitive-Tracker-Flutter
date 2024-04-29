import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.primary,
    primary: AppColor.primary,
    secondary: AppColor.secondary,
  ),
  scaffoldBackgroundColor: AppColor.scaffoldBackground,
  appBarTheme: const AppBarTheme(
    color: AppColor.primary,
    // color: AppColor.scaffoldBackground,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: const CardTheme(
    color: AppColor.secondary,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryTextColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryTextColor,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryTextColor,
    ),
    labelLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: AppColor.secondaryTextColor,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColor.secondaryTextColor,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColor.secondaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: AppColor.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColor.primaryTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColor.primaryTextColor,
    ),
  ),
);
