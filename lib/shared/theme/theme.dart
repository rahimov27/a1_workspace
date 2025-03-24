import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.cursorColor,
      cursorColor: AppColors.cursorColor,
      selectionHandleColor: AppColors.cursorColor),
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.scaffoldColor,
  ),
  colorScheme: ColorScheme.dark(primary: AppColors.mainRed),
);

ThemeData ligthTheme = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.cursorColor,
      cursorColor: AppColors.cursorColor,
      selectionHandleColor: AppColors.cursorColor),
  scaffoldBackgroundColor: AppColors.scaffoldWhiteColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.scaffoldWhiteColor,
  ),
  colorScheme: ColorScheme.dark(primary: AppColors.mainRed),
);
