import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HomeSubtitleWidget extends StatelessWidget {
  final String title;
  final bool hasButton;
  const HomeSubtitleWidget(
      {super.key, required this.title, required this.hasButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "sf",
            color: AppColors.mainWhite,
          ),
        ),
        const Spacer(),
        hasButton
            ? const Text(
                "Смотреть все",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "sf-medium",
                  color: AppColors.textGreyColor,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
