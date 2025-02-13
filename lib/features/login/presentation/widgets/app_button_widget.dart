import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double borderRadius;
  final VoidCallback? onPressed;

  const AppButtonWidget(
      {super.key,this.color, required this.text, this.borderRadius = 12, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.mainRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Радиус углов
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: "sf-medium",
            fontSize: 18,
            color: AppColors.mainWhite,
          ),
        ),
      ),
    );
  }
}
