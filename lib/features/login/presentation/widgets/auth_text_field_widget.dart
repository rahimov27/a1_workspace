import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool isSufficIcon;
  final bool isEye;
  final Widget? suffixIcon;

  const AuthTextFieldWidget(
      {super.key,
      this.isSufficIcon = false,
      this.suffixIcon,
      required this.hintText,
      required this.controller,
      this.isEye = false,
      this.isPasswordField = false});

  @override
  Widget build(BuildContext context) {
    // F6F6F6
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return TextField(
      inputFormatters: [LengthLimitingTextInputFormatter(20)],
      obscureText: isPasswordField,
      controller: controller,
      style: TextStyle(
          color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
      cursorColor: AppColors.mainRed.withOpacity(0.8),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: "sf-regualr",
            fontSize: 14,
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
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
