import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterButtonWidget extends StatelessWidget {
  final String text1, text2;
  final VoidCallback function;
  const RegisterButtonWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.function});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return GestureDetector(
      onTap: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: TextStyle(
                fontFamily: "sf-regular",
                color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
                fontSize: 12),
          ),
          Text(
            text2,
            style: TextStyle(
                fontFamily: "sf-regular",
                color: AppColors.mainRed,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}
