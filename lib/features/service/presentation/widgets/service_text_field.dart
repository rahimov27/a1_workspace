import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ServiceTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? textInputType;
  const ServiceTextField(
      {super.key,
      required this.text,
      this.textInputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return SizedBox(
      height: 50,
      child: TextField(
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
        ],
        controller: controller,
        style: TextStyle(
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
        // ignore: deprecated_member_use
        cursorColor: AppColors.mainRed.withOpacity(0.8),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
          hintText: text,
          hintStyle: TextStyle(
              fontFamily: "sf-regualr",
              fontSize: 14,
              color: isDarkMode
                  ? AppColors.mainWhite
                  : AppColors.bottomNavbarGrey),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: AppColors.mainRed, width: 1.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
