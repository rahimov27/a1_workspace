import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditPageTextField extends StatelessWidget {
  const EditPageTextField({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  final TextEditingController controller;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          style: TextStyle(
              fontFamily: "sf-regualr",
              fontSize: 14,
              color: isDarkMode
                  ? AppColors.mainWhite
                  : AppColors.bottomNavbarGrey),
          // ignore: deprecated_member_use
          cursorColor: AppColors.mainRed.withOpacity(0.8),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDarkMode ? AppColors.mainGrey : AppColors.mainWhite,
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
      ),
    );
  }
}
