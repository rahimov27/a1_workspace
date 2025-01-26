import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String hintText;
  const AuthTextFieldWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: AppColors.mainWhite),
      cursorColor: AppColors.mainRed.withOpacity(0.8),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            fontFamily: "sf-regualr", fontSize: 14, color: AppColors.mainWhite),
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
