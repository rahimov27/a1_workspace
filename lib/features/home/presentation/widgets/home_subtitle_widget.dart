import 'package:a1_workspace/features/home/presentation/pages/see_all_page.dart';
import 'package:a1_workspace/shared/core/styles/app_colors.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSubtitleWidget extends StatelessWidget {
  final String title;
  final bool hasButton;
  const HomeSubtitleWidget(
      {super.key, required this.title, required this.hasButton});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "sf",
            color: isDarkMode ? AppColors.mainWhite : AppColors.mainGrey,
          ),
        ),
        const Spacer(),
        hasButton
            ? GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeeAllPage())),
                child: const Text(
                  "Смотреть все",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "sf-medium",
                    color: AppColors.textGreyColor,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
