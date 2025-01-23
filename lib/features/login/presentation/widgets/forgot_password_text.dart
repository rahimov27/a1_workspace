import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const Text(
        "Забыли пароль?",
        style: TextStyle(
          fontFamily: "sf-regular",
          color: AppColors.mainWhite,
        ),
      ),
    );
  }
}
