import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppButtonWIdget extends StatelessWidget {
  const AppButtonWIdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Радиус углов
          ),
        ),
        child: const Text(
          'Войти',
          style: TextStyle(
            fontFamily: "sf-medium",
            fontSize: 18,
            color: AppColors.mainWhite,
          ),
        ),
      ),
    );
  }
}
