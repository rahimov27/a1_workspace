import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? textInputType;
  const ServiceTextField(
      {super.key, required this.text, this.textInputType, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(25),
        ],
        controller: controller,
        style: const TextStyle(color: AppColors.mainWhite),
        cursorColor: AppColors.mainRed.withOpacity(0.8),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.mainGrey,
          hintText: text,
          hintStyle: const TextStyle(
              fontFamily: "sf-regualr",
              fontSize: 14,
              color: AppColors.mainWhite),
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
