import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HomeSubtitleWidget extends StatelessWidget {
  const HomeSubtitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Записи",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
        Spacer(),
        Text(
          "Смотреть все",
          style: TextStyle(
            fontSize: 12,
            fontFamily: "sf-medium",
            color: AppColors.textGreyColor,
          ),
        ),
      ],
    );
  }
}
