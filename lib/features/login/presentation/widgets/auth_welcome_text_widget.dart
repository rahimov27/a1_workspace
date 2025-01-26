import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AuthWelcomeTextWidget extends StatelessWidget {
  const AuthWelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Вход",
          style: TextStyle(
            color: AppColors.mainWhite,
            fontSize: 30,
            fontFamily: "sf",
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Добро пожаловать в A1 workspace!",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, fontFamily: "sf", color: AppColors.greyAuth),
        ),
      ],
    );
  }
}
