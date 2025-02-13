import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.scaffoldColor,
  ),
);

ThemeData ligthTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.scaffoldWhiteColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.scaffoldWhiteColor,
  ),
);
