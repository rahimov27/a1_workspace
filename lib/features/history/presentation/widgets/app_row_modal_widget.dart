import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppRowModalWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final bool isDarkMode;
  final Color? statusColor;

  const AppRowModalWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.isDarkMode,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            firstText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontFamily: "sf-medium",
              color: Color(0xff919191),
            ),
          ),
          Spacer(),
          Expanded(
            child: Text(
              secondText,
              maxLines: 1,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "sf-medium",
                color: statusColor ??
                    (isDarkMode ? AppColors.mainWhite : AppColors.mainGrey),
                fontWeight:
                    FontWeight.bold, // Делаем статус жирным для выделения
              ),
            ),
          ),
        ],
      ),
    );
  }
}
