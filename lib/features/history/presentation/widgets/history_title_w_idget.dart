import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryTitleWIdget extends StatelessWidget {
  const HistoryTitleWIdget({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Text(
      "История",
      style: TextStyle(
        fontSize: 24,
        fontFamily: "sf",
        color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
      ),
    );
  }
}
