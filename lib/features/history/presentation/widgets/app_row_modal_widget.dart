import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppRowModalWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final bool isDarkMode;
  final Color? statusColor;
  final VoidCallback? onTap;

  const AppRowModalWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.isDarkMode,
    this.statusColor,
    this.onTap,
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
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                overflow: TextOverflow.ellipsis,
                secondText,
                maxLines: 5,
                textAlign: TextAlign.end,
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
          ),
        ],
      ),
    );
  }
}
