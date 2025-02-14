import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const AuthTextFieldWidget(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    // F6F6F6
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return TextField(
      controller: controller,
      style: TextStyle(
          color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
      cursorColor: AppColors.mainRed.withOpacity(0.8),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: "sf-regualr",
            fontSize: 14,
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(color: AppColors.mainRed, width: 1.5),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
